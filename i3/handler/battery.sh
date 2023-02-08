#!/bin/sh

ACPI_RES=$(acpi -b)
BAT_LEVEL=$(echo "$ACPI_RES" | grep -E -o "[0-9][0-9]?[0-9]?%" | grep -E -o "[0-9][0-9]?[0-9]")

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
