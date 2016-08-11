#! /bin/bash

# merge in defaults and keymaps
userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

## X11 config
exec xset s off &    # turn off screensaver (X11)
exec xset b off &    # turn off bell

#eval $(gnome-keyring-daemon --components=pkcs11,secrets,ssh,gpg)
#export GNOME_KEYRING_PID
#export GNOME_KEYRING_SOCKET
#export SSH_AUTH_SOCK
#export GPG_AGENT_INFO

## Keyboard layout: international english and italian
## switch between layouts pressing the "menu key".
#setxkbmap -layout us,it -variant intl, -option grp:menu_toggle
#xmodmap ~/.Xmodmap
#xsetroot -cursor_name left_ptr       # sets the usual cursor pointer
##compton --config ~/.compton.conf -b  # transparency
#numlockx &                           # turn on numlock keys
##xscreensaver -no-splash &            # screensaver daemon, managed w/ xautolock
## volumeicon &
##xfce4-power-manager &                # Xfce4 Power Manager
##nm-applet --sm-disable &             # NetworkManager applet
#urxvtd --quiet --opendisplay --fork & #urxvt daemon (run with urxvtc)
##mpd &                           # music player daemon
#thunar --daemon &
#thunar-volman &

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3 -V -d all > ~/.config/i3/i3log-$(date +'%Y%m%dT%H%M%S') 2>&1
#exec i3 -V -d all > ~/.config/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1
#exec spectrwm
#exec awesome
#exec gnome-session
#exec gnome-session --session=gnome-classic
#exec openbox-session
#exec startxfce4 --with-ck-launch
#exec xmonad
#exec startlxqt
#exec ssh-agent stumpwm
#exec sbcl --load ~/git/dotfiles/stumpwm-start
