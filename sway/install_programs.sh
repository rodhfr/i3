#!/bin/bash

# first install batch
sudo dnf update -y
sudo dnf install flatpak wayvnc azote openssl openssh-server nodejs pcmanfm ydotool yad waybar wl-clipboard kitty wget ffmpeg pavucontrol unrar lxpolkit gparted git rust cargo nodejs-npm vim firefox python3-pip rofi htop nvim fastfetch -y
sudo dnf copr enable pgdev/ghostty -y
sudo dnf install ghostty -y
sudo dnf copr enable erikreider/SwayNotificationCenter -y
sudo dnf install SwayNotificationCenter -y
pip3 install autotiling
sudo cp ~/.config/macopa/macopa ~/.local/bin
xdg-mime default pcmanfm.desktop inode/directory

# reboot sequence
LOCK_FILE="~/.config/sway/already.reboot"
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
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.adamcake.Bolt -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub io.github.getnf.embellish -y
flatpak install flathub io.mpv.Mpv -y
flatpak install flathub io.gitlab.librewolf-community -y

# more advanced setup
ssh-keygen
sudo systemctl start sshd
sudo systemctl enable sshd
sudo systemctl status sshd
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# setup docker
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker rodhfr
newgrp docker
docker run hello-world
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# install portainer (docker web gui)
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
echo "Setup Login in Portainer: https://localhost:9443"
