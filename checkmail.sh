#!/bin/sh

STATE=`nmcli -t -f state nm status`

if [ $STATE = 'connected' ]
then
    mbsync -a
    notmuch new
    exit 0
fi
echo "No internet connection."
exit 0

