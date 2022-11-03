#!/bin/bash

# SYSTEM CONFIG

# install packages
sudo apt install -y git stow tmux curl htop tree build-essential vlc neovim preload gimp gnome-tweaks transmission 
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
	 -o chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
 	 -o lutris.deb "https://github.com/lutris/lutris/releases/download/v0.5.12-beta1/lutris_0.5.12_beta1_all.deb" \
 	 -o steam.deb "https://cdn.akamai.steamstatic.com/client/installer/steam.deb" \
 	 -o code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" \
 	 -o jetbrains.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.26.4.13374.tar.gz"
sudo apt install -y /tmp/*.deb
tar xf /tmp/jetbrains.tar.gz -C /tmp
/tmp/jetbrains/jetbrains-toolbox
sudo apt remove --purge --assume-yes snapd
rm -rf ~/snap/
sudo rm -rf /var/cache/snapd/ 

# setup dotfiles
rm ~/.{bashrc,profile,bash_logout}
rmdir ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
mkdir ~/{.config,desktop,documents,downloads,pictures,public,videos}
cd ~/.dotfiles && stow files && dconf load / < dconf-settings.ini
