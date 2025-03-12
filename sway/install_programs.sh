#!/bin/bash

# first install batch
sudo dnf update -y
sudo dnf install flatpak pcmanfm ydotool yad waybar wl-clipboard kitty pavucontrol unrar lxpolkit gparted git rust cargo nodejs-npm vim firefox python3-pip rofi htop nvim fastfetch -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo dnf copr enable pgdev/ghostty -y
sudo dnf install ghostty -y
pip3 install autotiling
sudo cp ~/.config/macopa/macopa ~/.local/bin
xdg-mime default pcmanfm.desktop inode/directory

# reboot sequence
LOCK_FILE="./already.reboot"
if [ -e "$LOCK_FILE" ]; then
    rm "$LOCK_FILE"
    echo "Reboot sucessful. Proceeding with installation..."
else 
    touch "$LOCK_FILE"
    echo "Rebooting... Run the script again after the system reboots"
    sleep 5
    systemctl reboot
fi

# flatpaks installation
flatpak install flathub com.adamcake.Bolt -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub io.github.getnf.embellish -y
flatpak install flathub io.mpv.Mpv -y
flatpak install flathub io.gitlab.librewolf-community -y

