#!/bin/bash
sudo dnf update -y
sudo dnf install lxpolkit gparted git rust cargo nodejs-npm vim firefox python3-pip rofi htop nvim fastfetch -y
sudo dnf copr enable pgdev/ghostty -y
sudo dnf install ghostty -y
pip3 install autotiling
