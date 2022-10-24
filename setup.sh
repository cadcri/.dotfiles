#!/bin/bash

# SYSTEM CONFIG

# skip grub menu
sudo sed -i -E 's/GRUB_TIMEOUT=([[:digit:]]+)/GRUB_TIMEOUT=0/' /etc/default/grub
sudo update-grub

# enable hibernate on lid close and button press
sudo tee <<EOF /etc/systemd/logind.conf 1> /dev/null
[Login]
HandleLidSwitch=hibernate
HandlePowerKey=hibernate
EOF

# enable vsync on intel drivers
sudo tee <<EOF /etc/X11/xorg.conf.d/20-intel.conf 1> /dev/null
Section "Device"
   Identifier "Intel Graphics"
   Driver "intel"
   Option "AccelMethod"  "sna"
   Option "TearFree" "true"
   Option "DRI" "3"
EndSection
EOF


#####

# to not have screens asking for restart services
export DEBIAN_FRONTEND=noninteractive

# install packages
sudo apt install -y ntp bash-completion preload xterm git stow xorg i3 pulseaudio pulseaudio-module-bluetooth pamix tmux xclip curl htop rfkill policykit-1-gnome maim build-essential unzip

# setup dotfiles
rm ~/.bashrc ~/.profile ~/.bash_logout
mkdir ~/.config
stow files

# create folder for screenshots maim
mkdir -p ~/pictures/screenshots

# install neovim 
curl -LO https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo apt install -y ./nvim-linux64.deb
rm ./nvim-linux64.deb
curl -Lo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install chrome
curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

# install docker
sudo apt install -y docker.io
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl disable --now docker containerd

# install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo apt install -y ./minikube_latest_amd64.deb
rm ./minikube_latest_amd64.deb

sudo apt install -y network-manager


