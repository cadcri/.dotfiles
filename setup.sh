#!/bin/bash

# SYSTEM CONFIG

# enable hibernate on lid close and button press
sudo tee <<EOF /etc/systemd/logind.conf 1> /dev/null
[Login]
HandleLidSwitch=hibernate
HandlePowerKey=hibernate # do nothing on regolith
EOF

# to not have screens asking for restart services
# export DEBIAN_FRONTEND=noninteractive

# install packages
sudo apt install -y git stow tmux curl htop tree build-essential vlc neovim preload docker.io gimp
sudo snap install --classic intellij-idea-community android-studio
sudo snap install --beta steam 
sudo snap remove firefox

# install non apt/snap apps
 curl -L --output-dir /tmp \
	 -o discord.deb "https://discord.com/api/download?platform=linux&format=deb" \
	 -o minikube.deb "https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb" \
	 -o chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install -y /tmp/*.deb

# setup docker and kubernetes
sudo usermod -aG docker $USER && newgrp docker
minikube start && minikube delete --all
sudo systemctl disable --now docker containerd

# setup dotfiles
rm ~/.{bashrc,profile,bash_logout}
rmdir ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
mkdir ~/{.config,desktop,documents,downloads,pictures,public,videos}
cd ~/.dotfiles && stow files

