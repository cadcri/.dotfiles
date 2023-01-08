#!/bin/bash

rm ~/.{bashrc,profile,bash_logout}
cd ~/.dotfiles && stow files 
