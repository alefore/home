#!/bin/sh

#xmodmap -pke >/tmp/current-xmodmap && diff /tmp/current-xmodmap ~/.xmodmaprc | sed -n 's/^>//p' | xmodmap -
#xmodmap ~/.xmodmaprc
xkbcomp -I$HOME/.xkb $HOME/.xkb/map $DISPLAY
xrdb ~/.xrdb/xterm.xrdb
gtk-redshift -l 47.3667:8.5500 -v &
