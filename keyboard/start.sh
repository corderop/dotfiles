#!/bin/bash

sleep 2
xkbcomp ~/.pre-layout.xkb ":0" > /dev/null 2>&1
xkbcomp ~/.layout.xkb ":0" > /dev/null 2>&1
