#!/bin/bash
pkg update -y
pkg upgrade -y
pkg install zenity scrot pcmanfm picom vim feh nvim rust nodejs nodejs firefox python3-pip rofi htop fastfetch -y
pip3 install autotiling
