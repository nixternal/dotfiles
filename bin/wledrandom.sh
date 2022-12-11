#!/bin/sh
HOSTNAME='wled-dlamp1.local'
if nc -z "$HOSTNAME" 80 2>/dev/null; then
    PALETTE=$(shuf -i 0-70 -n 1)
    FX=$(shuf -i 0-117 -n 1)
    curl --silent "http://$HOSTNAME/win&FP=$PALETTE&FX=$FX" >/dev/null
fi
exit
