#! /bin/bash

# sets up gnome-keyring so that applications can use it
eval `gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh`
export GNOME_KEYRING_CONTROL
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_PID

# merge in defaults and keymaps
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -s "$usermodmap" ]; then
    xmodmap "$usermodmap"
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

# xsetroot -cursor_name left_ptr       # sets the usual cursor pointer
# setxkbmap us -variant intl           # keyboard layout
# compton --config ~/.compton.conf -b  # transparency
# numlockx &                           # turn on numlock keys
# xscreensaver -no-splash &            # screensaver daemon, managed w/ xautolock
# # volumeicon &
# xfce4-power-manager &                # Xfce4 Power Manager
# nm-applet --sm-disable &             # NetworkManager applet
# # dropboxd &                         # dropbox sync client
# # emacs --daemon &
# urxvtd --quiet --opendisplay --fork & #urxvt daemon (run with urxvtc)
# #mpd &                           # music player daemon
# #keepassx &                      # password manager
# thunar --daemon &
# thunar-volman &

## DE selection (awesome kept as default)
session=${1:-stumpwm}

case $session in
    awesome           ) exec awesome;;
    cinnamon          ) exec cinnamon-session;;
    dwm               ) exec dwm;;
    enlightenment     ) exec enlightenment_start;;
    gnome             ) exec gnome-session;;
    gnome-classic     ) exec gnome-session --session=gnome-classic;;
    i3|i3wm           ) exec i3;;
    kde               ) exec startkde;;
    mate              ) exec mate-session;;
    openbox           ) exec openbox-session;;
    unity             ) exec unity;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad            ) exec xmonad;;
    lxqt              ) exec startlxqt;;
    stumpwm           ) exec ssh-agent stumpwm;;
    # No known session, try to run it as command
    *) exec $1;;
esac
