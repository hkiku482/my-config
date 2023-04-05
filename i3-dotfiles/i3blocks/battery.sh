#!/bin/sh

BAT_LEVEL=$(acpi -b | awk -F'[,][ ]' '{print $2}' | awk -F'[%]' '{print $1}')

# Battery Symbol
BAT_SYMBOL="\uf240"
if [ $BAT_LEVEL -lt 10 ]; then
    BAT_SYMBOL="\uf244"
elif [ $BAT_LEVEL -lt 30 ]; then
    BAT_SYMBOL="\uf243"
elif [ $BAT_LEVEL -lt 60 ]; then
    BAT_SYMBOL="\uf242"
elif [ $BAT_LEVEL -lt 80 ]; then
    BAT_SYMBOL="\uf241"
fi

echo -e "$BAT_SYMBOL $BAT_LEVEL% "
