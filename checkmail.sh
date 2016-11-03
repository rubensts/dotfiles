#!/bin/sh

# Check mail every minute
while true; do
    mbsync -a
    /usr/bin/notmuch new 
    ~/.local/bin/afew -tn
    sleep 60
done
