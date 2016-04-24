#! /bin/bash

# sets up gnome-keyring so that applications can use it
#eval `gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh`
#export GNOME_KEYRING_CONTROL
#export SSH_AUTH_SOCK
#export GPG_AGENT_INFO
#export GNOME_KEYRING_PID

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

# X11 config
exec xset s off &    # turn off screensaver (X11)
exec xset b off &    # turn off bell

# Sets italian as the default layout, having international english as
# alternative. To switch between layouts press the "menu key".
setxkbmap -layout it,us -variant ,intl -option grp:menu_toggle
xmodmap ~/.Xmodmap
xsetroot -cursor_name left_ptr       # sets the usual cursor pointer
#compton --config ~/.compton.conf -b  # transparency
numlockx &                           # turn on numlock keys
#xscreensaver -no-splash &            # screensaver daemon, managed w/ xautolock
# volumeicon &
xfce4-power-manager &                # Xfce4 Power Manager
# nm-applet --sm-disable &             # NetworkManager applet
urxvtd --quiet --opendisplay --fork & #urxvt daemon (run with urxvtc)
#mpd &                           # music player daemon
thunar --daemon &
thunar-volman &

#exec i3
#exec awesome
#exec gnome-session
#exec gnome-session --session=gnome-classic
#exec openbox-session
#exec startxfce4
#exec xmonad
#exec startlxqt
exec ssh-agent stumpwm
