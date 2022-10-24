#!/bin/bash

sudo apt install -y wget gpg
wget -qO - https://regolith-desktop.org/regolith.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
https://regolith-desktop.org/release-debian-bullseye-amd64 debian main" | \
sudo tee /etc/apt/sources.list.d/regolith.list

sudo apt update
sudo apt install -y regolith-desktop regolith-look-* i3xrocks-focused-window-name i3xrocks-rofication i3xrocks-info i3xrocks-app-launcher i3xrocks-memory i3xrocks-battery regolith-compositor-picom-glx 
sudo apt upgrade
