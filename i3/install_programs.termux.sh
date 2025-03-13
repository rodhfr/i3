#!/bin/bash
#sudo dnf update -y
#sudo dnf install git rust cargo nodejs-npm vim firefox python3-pip rofi htop nvim fastfetch -y
pkg update -y
pkg upgrade -y
pkg install zenity picom vim feh nvim rust nodejs nodejs firefox python3-pip rofi htop fastfetch -y
#sudo dnf copr enable pgdev/ghostty -y
#sudo dnf install ghostty -y
pip3 install autotiling
