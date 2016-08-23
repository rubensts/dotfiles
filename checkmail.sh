#!/bin/sh

# Keychain
#eval `keychain --quiet --noask --eval --agents ssh,gpg id_rsa 6BB1CF3B`

# Check mail every minute
while true; do
    mbsync -a
    notmuch new
    ~/.local/bin/afew -tn
    sleep 60
done
