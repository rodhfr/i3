# Instlal apps
sudo dnf update
sudo dnf upgrade
sudo dnf install xclip 
# Create the $HOME/opt destination folder
mkdir -p ~/opt
# Download the AppImage inside it
wget -O ~/opt/Espanso.AppImage 'https://github.com/espanso/espanso/releases/download/v2.2.1/Espanso-X11.AppImage'
# Make it executable
# this wget is download another file renme to Espanso.AppImage
# i did use gearlever also
chmod u+x ~/opt/Espanso.AppImage
# Create the "espanso" command alias
sudo ~/opt/Espanso.AppImage env-path register
