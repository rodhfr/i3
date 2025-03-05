# Instlal apps
sudo dnf update
sudo dnf upgrade
sudo dnf install xclip fuse-libs fuse-overlayfs kitty feh python3-pip bat rofi flatpak -y
pip install autotiling

# bashrc
echo "alias xclip='xclip -selection clipboard'" >> ~/.bashrc
echo 'export PATH=$PATH:/var/lib/flatpak/exports/bin' >> ~/.bashrc
source ~/.bashrc

# add flathub and apps
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub it.mijorus.gearlever
# Create the $HOME/opt destination folder
mkdir -p ~/opt
# Download the AppImage inside it
wget -O ~/opt/Espanso.AppImage 'https://github.com/espanso/espanso/releases/download/v2.2.1/Espanso-X11.AppImage'
mv ~/opt/Espanso.AppImage ~/opt/espanso
# Make it executable
# this wget is download another file renme to Espanso.AppImage
# i did use gearlever also
chmod u+x ~/opt/espanso
# Create the "espanso" command alias
sudo ~/opt/espanso env-path register
espanso service register
espanso start
