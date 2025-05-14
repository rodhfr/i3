#!/bin/bash

# this is only for setup git --global username and email
# change for your own otherwise your git commits would be signed in my name
USER_EMAIL="souzafrodolfo@gmail.com"
USER_NAME="Rodolfo Franca"


### installing minimal needed layers for this setup to work
# rofi is to be able to launch flatpaks from host
# alacritty is a host enabled terminal
# sway is the wayland compositor installed in on the host
#sudo rpm-ostree install alacritty rofi sway


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
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install xdg-desktop-portal-wlr -y 
sudo dnf install input-remapper -y
sudo dnf copr enable alternateved/keyd -y
sudo dnf install keyd -y
sudo dnf install golang -y
sudo dnf install texlive-scheme-basic -y
sudo dnf install gedit -y
sudo dnf install ncurses-devel -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf install intel-media-driver -y
sudo dnf install gnome-software -y
# more about this change ffmpeg
# https://rpmfusion.org/Howto/Multimedia
sudo dnf install bat -y
sudo dnf install lxpolkit -y
sudo dnf install fuse-overlayfs -y
sudo dnf install azote -y
sudo dnf install nautilus -y
sudo dnf install openssl -y
sudo dnf install swaybg -y
sudo dnf install nodejs -y
sudo dnf install wl-mirror -y
sudo dnf install pcmanfm -y
sudo dnf install ydotool -y 
sudo dnf install fuse-devel -y 
sudo dnf install yad -y
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
sudo dnf install cargo  -y
sudo dnf install libva-utils  -y
sudo dnf install nodejs-npm  -y
sudo dnf install vim  -y
sudo dnf install firefox  -y
sudo dnf install rofi  -y
sudo dnf install htop  -y
sudo dnf install nvim -y
sudo dnf install fastfetch -y
sudo dnf install python3-pip -y
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1 # for fedora 41
sudo dnf install steam -y
sudo dnf install emacs -y
sudo dnf install fd -y
# more info about steam install in fedora 41
# https://docs.fedoraproject.org/en-US/gaming/proton/


source ~/.bashrc
pip3 install autotiling 
# azote won't work on distrobox because it needs swaymsg -t display
# it is workaroundable but i'm not implementing this now
# just put your images in the ~./config/sway/Wallpaper folder and it will
# randomly change

sudo dnf copr enable pgdev/ghostty -y
sudo dnf install ghostty -y
sudo dnf copr enable erikreider/SwayNotificationCenter -y
sudo dnf install SwayNotificationCenter -y
mkdir -p ~/.local/bin/
sudo cp ~/.config/macopa/macopa ~/.local/bin/
xdg-mime default org.kde.dolphin.desktop inode/directory
#xdg-mime default pcmanfm.desktop inode/directory

git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"

# install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code -y



### ON HOST (NOT INSIDE DISTROBOX)
# flatpaks installation
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.adamcake.Bolt -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub io.github.plrigaux.sysd-manager -y
flatpak install flathub org.kde.dolphin -y
flatpak install flathub net.lutris.Lutris -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub io.github.getnf.embellish -y
flatpak install flathub io.mpv.Mpv -y
flatpak install flathub io.gitlab.librewolf-community -y
flatpak install flathub one.ablaze.floorp -y
flatpak install flathub org.nickvision.tubeconverter -y
flatpak install flathub it.mijorus.gearlever -y
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
#--------
# ON HOST (alternative):
#rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker rodhfr
docker run hello-world
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# install portainer (docker web gui)
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
echo "Setup Login in Portainer: https://localhost:9443"
docker network create arr
sudo chown -R rodhfr:rodhfr ~/Docker/
sudo chown -R rodhfr:rodhfr ~/Jellyfin\ Server\ Media/

sudo systemctl enable keyd
# setup xdg-desktop-portal
# https://gist.github.com/rodhfr/181a0bee00ad5f7a608bc3e1bd021be5
