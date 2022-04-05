#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetCapsLockState, AlwaysOff

CapsLock & i::Send {Up}
CapsLock & j::Send {Left}
CapsLock & k::Send {Down}
CapsLock & l::Send {Right}
CapsLock & SC027::Send {Backspace}
CapsLock & p::Send {Delete}
CapsLock & u::Send {PgUp}
CapsLock & o::Send {PgDn}

CapsLock & f::Send {Shift down}
CapsLock & f up::Send {Shift up}

CapsLock & d::Send {Ctrl down}
CapsLock & d up::Send {Ctrl up}

CapsLock & s::Send {LAlt down}
CapsLock & s up::Send {LAlt up}

return