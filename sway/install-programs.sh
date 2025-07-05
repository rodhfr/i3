#!/bin/bash

# this is only for setup git --global username and email
# change for your own otherwise your git commits would be signed in my name
USER_EMAIL="souzafrodolfo@gmail.com"
USER_NAME="Rodolfo Franca"

# DNF INSTALLATION 
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install xdg-desktop-portal-wlr -y 
sudo dnf copr enable alternateved/keyd -y
sudo dnf copr enable erikreider/SwayNotificationCenter -y
sudo dnf install keyd -y
sudo dnf install obs-studio -y
sudo dnf install golang -y
sudo dnf install openssh-server -y
sudo dnf install gedit -y
sudo dnf install ncurses-devel -y
# more about this change ffmpeg
# https://rpmfusion.org/Howto/Multimedia
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf install ImageMagick -y
sudo dnf install intel-media-driver -y
sudo dnf install gnome-software -y
sudo dnf install solaar solaar-udev -y
sudo dnf install bat -y
sudo dnf install lxpolkit -y
sudo dnf install gnome-disk-utility -y
sudo dnf install fuse-overlayfs -y
sudo dnf install azote -y
sudo dnf install nautilus -y
sudo dnf install openssl -y
sudo dnf install swaybg -y
sudo dnf install nodejs -y
sudo dnf install wl-mirror -y
sudo dnf install ydotool -y 
sudo dnf install fuse-devel -y 
sudo dnf install yad -y
sudo dnf install ncdu -y
sudo dnf install nautilus-open-any-terminal -y
sudo dnf install foot -y
sudo dnf install alsa-lib-devel -y
sudo dnf install mkvtoolnix -y
sudo dnf install distrobox -y
sudo dnf install libxkbcommon-x11-devel libXcur -y
sudo dnf install mesa-libEGL-devel -y
sudo dnf install libX11-devel -y
sudo dnf install vulkan-devel -y
sudo dnf install solaar solaar-udev -y
sudo dnf install dejavu-sans-fonts -y
sudo dnf install ventoy -y
sudo dnf install -y
sudo dnf install waybar -y
sudo dnf install wl-clipboard -y
sudo dnf install kitty -y
sudo dnf install wget -y
sudo dnf install ffmpeg -y
sudo dnf install pavucontrol -y
sudo dnf install flatpak -y
sudo dnf install unrar -y
sudo dnf install git -y
sudo dnf install rust  -y
sudo dnf install @virtualization -y
sudo dnf install aria2 -y
sudo dnf install gparted -y
sudo dnf install cargo  -y
sudo dnf install libva-utils  -y
sudo dnf install nodejs-npm  -y
sudo dnf install vim  -y
sudo dnf install firefox  -y
sudo dnf install rofi  -y
sudo dnf install htop  -y
sudo dnf install nvim -y
sudo dnf install fastfetch -y
sudo dnf install nmtui -y
sudo dnf install rclone -y
sudo dnf install python3-pip -y
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1 # for fedora 41
sudo dnf install steam -y
sudo dnf install emacs -y
sudo dnf install fd -y
sudo dnf install alacritty -y
sudo dnf install SwayNotificationCenter -y

# Git Setup
git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"

# PYTHON REPO INSTALL
pip3 install pipx 
pipx install yt-dlp
pipx install autotiling -y

# Bashrc Setup
cp ~/.config/sway/bashrc ~/.bashrc
source ~/.bashrc

# Setup default xdg-mime
xdg-mime default nautilus.desktop inode/directory

# install vscode from custom repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code -y

# flatpaks installation
## user installations
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub com.adamcake.Bolt -y
flatpak install --user flathub com.bitwarden.desktop -y
flatpak install --user flathub org.gnome.Loupe -y
flatpak install --user flathub org.gnome.Crosswords -y
flatpak install --user flathub org.torproject.torbrowser-launcher -y
flatpak install --user flathub org.qbittorrent.qBittorrent -y
flatpak install --user flathub io.github.josephmawa.Bella -y
flatpak install --user flathub com.discordapp.Discord -y
flatpak install --user flathub com.rtosta.zapzap -y
flatpak install --user flathub io.github.sigmasd.share -y
flatpak install --user flathub com.github.iwalton3.jellyfin-media-player -y
flatpak install --user flathub io.github.getnf.embellish -y
flatpak install --user flathub org.libreoffice.LibreOffice -y
flatpak install --user flathnet.sourceforge.gMKVExtractGUIub io.mpv.Mpv -y
flatpak install --user flathub com.belmoussaoui.Decoder -y
flatpak install --user flathub net.ankiweb.Anki -y
flatpak install --user https://flatpak.nils.moe/repo/appstream/net.sourceforge.gMKVExtractGUI.flatpakref -y
flatpak install --user flathub org.freedesktop.Sdk.Extension.mono6//24.08 -y
flatpak install --user flathub com.stremio.Stremio -y
flatpak install --user flathub io.gitlab.liferooter.TextPieces -y 
flatpak install --user org.torproject.torbrowser-launcher -y
## system installations 
flatpak install --system flathub com.github.tchx84.Flatseal -y
flatpak install --system io.github.flattool.Warehouse -y
flatpak install --system flathub io.github.plrigaux.sysd-manager -y
flatpak install --system flathub io.github.giantpinkrobots.flatsweep -y
# more advanced setup
ssh-keygen
sudo systemctl start sshd
sudo systemctl enable sshd
sudo systemctl status sshd
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# Docker Setup
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
sudo dnf install dnf-plugins-core -y
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker rodhfr
docker run hello-world
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

## Portainer Setup
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
echo "Setup Login in Portainer: https://localhost:9443"
docker network create arr
docker network create arranime

sudo systemctl enable keyd
# setup xdg-desktop-portal
# https://gist.github.com/rodhfr/181a0bee00ad5f7a608bc3e1bd021be5
