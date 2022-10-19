#!/bin/sh

setxkbmap -option "ctrl:swapcaps"
xset r rate 250 35
xrdb -merge ~/.xresources


! quand il n'y a pas de fichier xinitrc alors il en utilise un autre et lance i3 aussi
! mais si on a un fichier xinitrc alros il faut mettre exec i3 sinon le xserver ne lance rien
! et s'arrete
exec i3

