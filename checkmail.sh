#!/bin/sh

# Keychain
eval `keychain --noask --eval --agents ssh,gpg id_rsa 6BB1CF3B`

# Only run if connected
STATE=`nmcli -t -f state nm status`

if [ $STATE = 'connected' ]
then
    mbsync -a
    notmuch new
    exit 0
fi
echo "No internet connection."
exit 0

