#!/bin/bash

sleep 2
xkbcomp ~/.layout/.pre-layout.xkb ":0"
xkbcomp ~/.layout/.layout.xkb ":0"
