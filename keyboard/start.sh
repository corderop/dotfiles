#!/bin/bash

sleep 2
xkbcomp ~/.layout.xkb ":0" > /dev/null 2>&1
