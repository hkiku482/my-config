#!/bin/sh

AUDIO_VOLUME=$(pamixer --get-volume)
AUDIO_SYMBOL=""
if [ $AUDIO_VOLUME -eq 0 ]; then
    AUDIO_SYMBOL="\uf026"
elif [ $AUDIO_VOLUME -lt 33 ]; then
    AUDIO_SYMBOL="\uf027"
else
    AUDIO_SYMBOL="\uf028"
fi

if [ $(pamixer --get-mute) == "true" ]; then
    echo -e "$AUDIO_SYMBOL mute"
else
    echo -e "$AUDIO_SYMBOL $AUDIO_VOLUME%"
fi
