local eventtap = hs.eventtap
local event = eventtap.event
local hid = hs.hid
local keycodes = hs.keycodes.map
local timer = hs.timer

local EVENT_TYPES = event.types
local EVENT_PROPERTIES = event.properties
local SYNTHETIC_EVENT_MARKER = 0x48534D50
local ESCAPE_DELAY_SECONDS = 0.150
local MODIFIER_NAMES = { "cmd", "alt", "shift", "ctrl", "fn" }
local CAPSLOCK_TO_F18_MAPPING = [[{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}]]
local DEFAULT_KEY_MAPPING = [[{"UserKeyMapping":[]}]]

local KEY = {
	escape = keycodes.escape,
	f18 = keycodes.f18,
	left = keycodes.left,
	right = keycodes.right,
	up = keycodes.up,
	down = keycodes.down,
	pageup = keycodes.pageup,
	pagedown = keycodes.pagedown,
	delete = keycodes.delete,
	forwarddelete = keycodes.forwarddelete,
	alt = keycodes.alt,
	cmd = keycodes.cmd,
	shift = keycodes.shift,
	j = keycodes.j,
	k = keycodes.k,
	i = keycodes.i,
	l = keycodes.l,
	o = keycodes.o,
	u = keycodes.u,
	g = keycodes.g,
	semicolon = keycodes[";"],
	p = keycodes.p,
	s = keycodes.s,
	d = keycodes.d,
	f = keycodes.f,
}

local layerActive = false
local sendEscape = false
local activeLayerMappings = {}
local pendingLayerKeyUps = {}
local pendingWindowsKeyUps = {}
local escapeTimer = timer.delayed.new(ESCAPE_DELAY_SECONDS, function()
	sendEscape = false
end)

local layerBindings = {
	[KEY.j] = { kind = "replaceKey", outputKeyCode = KEY.left },
	[KEY.l] = { kind = "replaceKey", outputKeyCode = KEY.right },
	[KEY.i] = { kind = "replaceKey", outputKeyCode = KEY.up },
	[KEY.k] = { kind = "replaceKey", outputKeyCode = KEY.down },
	[KEY.u] = { kind = "replaceKey", outputKeyCode = KEY.pageup },
	[KEY.o] = { kind = "replaceKey", outputKeyCode = KEY.pagedown },
	[KEY.semicolon] = { kind = "replaceKey", outputKeyCode = KEY.delete },
	[KEY.p] = { kind = "replaceKey", outputKeyCode = KEY.forwarddelete },
	[KEY.s] = { kind = "modifier", outputKeyCode = KEY.alt },
	[KEY.d] = { kind = "modifier", outputKeyCode = KEY.cmd },
	[KEY.f] = { kind = "modifier", outputKeyCode = KEY.shift },
	[KEY.g] = { kind = "capsToggle" },
}

local windowsLikeRules = {
	{ inputKeyCode = KEY.left, fromFlags = { cmd = true }, toFlags = { alt = true } },
	{ inputKeyCode = KEY.right, fromFlags = { cmd = true }, toFlags = { alt = true } },
	{ inputKeyCode = KEY.left, fromFlags = { cmd = true, shift = true }, toFlags = { alt = true, shift = true } },
	{ inputKeyCode = KEY.right, fromFlags = { cmd = true, shift = true }, toFlags = { alt = true, shift = true } },
	{ inputKeyCode = KEY.delete, fromFlags = { cmd = true }, toFlags = { alt = true } },
	{ inputKeyCode = KEY.forwarddelete, fromFlags = { cmd = true }, toFlags = { alt = true } },
}

local function ensureCapsLockRemap()
	os.execute("/usr/bin/hidutil property --set '" .. CAPSLOCK_TO_F18_MAPPING .. "' >/dev/null 2>&1")
end

local function restoreDefaultKeyMapping()
	os.execute("/usr/bin/hidutil property --set '" .. DEFAULT_KEY_MAPPING .. "' >/dev/null 2>&1")
	hid.capslock.set(false)
end

local function isSynthetic(eventObject)
	return eventObject:getProperty(EVENT_PROPERTIES.eventSourceUserData) == SYNTHETIC_EVENT_MARKER
end

local function markSynthetic(eventObject)
	eventObject:setProperty(EVENT_PROPERTIES.eventSourceUserData, SYNTHETIC_EVENT_MARKER)
	return eventObject
end

local function normalizedFlags(flags)
	local result = {}

	for _, modifierName in ipairs(MODIFIER_NAMES) do
		if flags[modifierName] then
			result[modifierName] = true
		end
	end

	return result
end

local function exactFlagsMatch(flags, expectedFlags)
	local currentFlags = normalizedFlags(flags)

	for _, modifierName in ipairs(MODIFIER_NAMES) do
		if (currentFlags[modifierName] or false) ~= (expectedFlags[modifierName] or false) then
			return false
		end
	end

	return true
end

local function currentLayerModifierFlags(baseFlags)
	local combinedFlags = normalizedFlags(baseFlags or {})

	for _, descriptor in pairs(activeLayerMappings) do
		if descriptor.kind == "modifier" then
			if descriptor.outputKeyCode == KEY.alt then
				combinedFlags.alt = true
			elseif descriptor.outputKeyCode == KEY.cmd then
				combinedFlags.cmd = true
			elseif descriptor.outputKeyCode == KEY.shift then
				combinedFlags.shift = true
			end
		end
	end

	return combinedFlags
end

local function escapeEvents()
	return {
		markSynthetic(event.newKeyEvent(KEY.escape, true)),
		markSynthetic(event.newKeyEvent(KEY.escape, false)),
	}
end

local function postEvents(events)
	for _, eventObject in ipairs(events) do
		eventObject:post()
	end
end

local function beginLayer()
	layerActive = true
	sendEscape = true
	escapeTimer:start()
end

local function releaseLayerMappings()
	for keyCode, descriptor in pairs(activeLayerMappings) do
		activeLayerMappings[keyCode] = nil
	end

	for keyCode, _ in pairs(pendingLayerKeyUps) do
		pendingLayerKeyUps[keyCode] = nil
	end
end

local function finishLayer()
	if not layerActive and not sendEscape then
		return
	end

	layerActive = false
	escapeTimer:stop()
	releaseLayerMappings()

	if sendEscape then
		postEvents(escapeEvents())
	end

	sendEscape = false
end

hs.shutdownCallback = function()
	escapeTimer:stop()
	finishLayer()
	restoreDefaultKeyMapping()
end

local function emitDescriptor(originalEvent, descriptor, isDown)
	if descriptor.kind == "replaceKey" then
		local replacement = markSynthetic(originalEvent:copy())
		replacement:setKeyCode(descriptor.outputKeyCode)
		replacement:setFlags(descriptor.fixedFlags or currentLayerModifierFlags(originalEvent:getFlags()))
		return { replacement }
	end

	if descriptor.kind == "modifier" then
		return {}
	end

	if descriptor.kind == "capsToggle" and isDown then
		layerActive = false
		sendEscape = false
		escapeTimer:stop()
		hid.capslock.toggle()
		return {}
	end

	return {}
end

local function matchingWindowsRule(eventObject)
	local keyCode = eventObject:getKeyCode()
	local flags = eventObject:getFlags()

	for _, rule in ipairs(windowsLikeRules) do
		if rule.inputKeyCode == keyCode and exactFlagsMatch(flags, rule.fromFlags) then
			return {
				kind = "replaceKey",
				outputKeyCode = rule.inputKeyCode,
				fixedFlags = rule.toFlags,
			}
		end
	end

	return nil
end

local keyboardTap = eventtap.new({ EVENT_TYPES.keyDown, EVENT_TYPES.keyUp }, function(eventObject)
	if isSynthetic(eventObject) then
		return false
	end

	local eventType = eventObject:getType()
	local isDown = eventType == EVENT_TYPES.keyDown
	local keyCode = eventObject:getKeyCode()

	if keyCode == KEY.f18 then
		if isDown then
			beginLayer()
		else
			finishLayer()
		end
		return true
	end

	local activeDescriptor = activeLayerMappings[keyCode]
	if activeDescriptor then
		local emittedEvents = emitDescriptor(eventObject, activeDescriptor, isDown)
		if not isDown then
			activeLayerMappings[keyCode] = nil
		end
		return true, emittedEvents
	end

	if pendingLayerKeyUps[keyCode] then
		pendingLayerKeyUps[keyCode] = nil
		local passthroughEvent = markSynthetic(eventObject:copy())
		passthroughEvent:setFlags(currentLayerModifierFlags(eventObject:getFlags()))
		return true, { passthroughEvent }
	end

	if not isDown then
		local windowsDescriptor = pendingWindowsKeyUps[keyCode]
		if windowsDescriptor then
			pendingWindowsKeyUps[keyCode] = nil
			return true, emitDescriptor(eventObject, windowsDescriptor, false)
        end
		return false
	end

	if layerActive then
		sendEscape = false
		escapeTimer:stop()

		local descriptor = layerBindings[keyCode]
		if descriptor then
			if descriptor.kind ~= "capsToggle" then
				activeLayerMappings[keyCode] = descriptor
			end
			return true, emitDescriptor(eventObject, descriptor, true)
		end

		local modifierFlags = currentLayerModifierFlags(eventObject:getFlags())
		if next(modifierFlags) ~= nil then
			pendingLayerKeyUps[keyCode] = true
			local passthroughEvent = markSynthetic(eventObject:copy())
			passthroughEvent:setFlags(modifierFlags)
			return true, { passthroughEvent }
		end
	end

	local windowsDescriptor = matchingWindowsRule(eventObject)
	if windowsDescriptor then
		pendingWindowsKeyUps[keyCode] = windowsDescriptor
		return true, emitDescriptor(eventObject, windowsDescriptor, true)
	end

	return false
end)

ensureCapsLockRemap()
hid.capslock.set(false)
keyboardTap:start()

return {
	keyboardTap = keyboardTap,
}
