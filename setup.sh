#!/bin/bash

# SYSTEM CONFIG

# install packages
sudo apt install -y git stow tmux curl htop tree build-essential vlc neovim preload gimp gnome-tweaks qbittorrent
sudo snap install --classic intellij-idea-community android-studio code
sudo snap install --beta steam 
sudo snap remove firefox

# setup docker 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# install non apt/snap apps
 curl -L --output-dir /tmp \
	 -o discord.deb "https://discord.com/api/download?platform=linux&format=deb" \
	 -o docker.deb "https://desktop.docker.com/linux/main/amd64/docker-desktop-4.13.1-amd64.deb" \
	 -o chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install -y /tmp/*.deb


# setup dotfiles
rm ~/.{bashrc,profile,bash_logout}
rmdir ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
mkdir ~/{.config,desktop,documents,downloads,pictures,public,videos}
cd ~/.dotfiles && stow files && dconf load / < dconf-settings.ini
