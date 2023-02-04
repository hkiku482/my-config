#!/bin/sh

BLANK='#00000000'
INSIDE='#ffffff40'
DEFAULT='#137dd4ff'
KEYPAD='#ffffffff'
VERIFYING='#13a813ff'
WRONG='#d41313ff'

i3lock \
--line-color=$BLANK \
--separator-color=$BLANK \
--inside-color=$INSIDE \
--insidever-color=$INSIDE \
--insidewrong-color=$INSIDE \
\
--keyhl-color=$KEYPAD \
--bshl-color=$KEYPAD \
\
--time-color=$DEFAULT \
--date-color=$DEFAULT \
--ring-color=$DEFAULT \
\
--verif-color=$VERIFYING \
--ringver-color=$VERIFYING \
\
--wrong-color=$WRONG \
--ringwrong-color=$WRONG \
\
--screen 1            \
--blur 5              \
--clock               \
--indicator           \
--time-str="%H:%M:%S" \
--date-str="%Y-%m-%d" \