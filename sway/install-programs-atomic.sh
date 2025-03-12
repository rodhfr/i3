#!/bin/bash


###### DISTROBOX SETUP FEDORA IMAGE LATEST
# SETUP ON HOST (not distrobox)
# openssh-server
# optional (if not kinoite or bazzite)
#lxpolkit flatpak wayvnc
# SETUP GIT AND PULL REPO
### create a distrobox container
#distrobox create --name devbox -i fedora:latest --hostname devbox
#distrobox enter devbox

### INSIDE DISTROBOX:
# first install batch
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install azote openssl nodejs pcmanfm ydotool yad waybar wl-clipboard kitty wget ffmpeg pavucontrol unrar git rust cargo nodejs-npm vim firefox python3-pip rofi htop nvim fastfetch -y

sudo dnf copr enable pgdev/ghostty -y
sudo dnf install ghostty -y
sudo dnf copr enable erikreider/SwayNotificationCenter -y
sudo dnf install SwayNotificationCenter -y
pip3 install autotiling
sudo cp ~/.config/macopa/macopa ~/.local/bin
xdg-mime default pcmanfm.desktop inode/directory

# install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code -y

# reboot sequence
LOCK_FILE="~/.config/sway/already.reboot"
if [ -e "$LOCK_FILE" ]; then
    rm "$LOCK_FILE"
    echo "Reboot sucessful. Proceeding with installation..."
else 
    touch "$LOCK_FILE"
    echo "Rebooting... Run the script again after the system reboots"
    sleep 5
    sudo reboot
fi


### ON HOST (NOT INSIDE DISTROBOX)
# flatpaks installation
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.adamcake.Bolt -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub io.github.getnf.embellish -y
flatpak install flathub io.mpv.Mpv -y
flatpak install flathub io.gitlab.librewolf-community -y

# more advanced setup
#ssh-keygen
#sudo systemctl start sshd
#sudo systemctl enable sshd
#sudo systemctl status sshd
#sudo firewall-cmd --permanent --add-service=ssh
#sudo firewall-cmd --reload

#--------\
#THIS IS NOT WORKING
# setup docker in a specific distrobox container
#sudo touch /var/run/distrobox_docker/
#sudo chmod -R 0777 /var/run/distrobox_docker/
#distrobox create --name dockertainer -i fedora:latest --additional-packages "systemd docker vim socat" --init --unshare-all --volume /var/run/distrobox_docker:/var/run/distrobox_docker --hostname dockertainer
#distrobox enter dockertainer
#sudo dnf remove docker \
#                  docker-client \
#                  docker-client-latest \
#                  docker-common \
 #                 docker-latest \
 #                 docker-latest-logrotate \
#                  docker-logrotate \
#                  docker-selinux \
#                  docker-engine-selinux \
#                  docker-engine
#sudo dnf -y install dnf-plugins-core
#sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
#sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#--------
# ON HOST (alternative):
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker rodsway
newgrp docker
docker run hello-world
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# install portainer (docker web gui)
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
echo "Setup Login in Portainer: https://localhost:9443"



