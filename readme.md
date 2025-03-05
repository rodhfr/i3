# Instlal apps
sudo dnf update
sudo dnf upgrade
sudo dnf install tigervnc-server xclip fuse-libs fuse-overlayfs kitty feh python3-pip bat rofi flatpak -y
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

# setup vnc
vncpasswd
mkdir ~/.vnc/

echo -e '#!/bin/sh\n\nxrdb $HOME/.Xresources\nxsetroot -solid grey\n#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &\n#x-window-manager &\n#Fix to make GNOME work\nexport XKL_XMODMAP_DISABLE=1\n#/etc/X11/Xsession\ni3 &' > ~/.vnc/xstartup && chmod +x ~/.vnc/xstartup

sudo bash -c 'echo -e "[Unit]\nDescription=remote desktop service (vnc)\nAfter=syslog.target network.target\n\n[Service]\nType=forking\nUser=rodhfr\n\n# Clean any existing files in /tmp/.x11-unix environment\nExecStartPre=/bin/sh -c \"/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :\"\nExecStart=/usr/bin/vncserver -geometry 1920x1080 -depth 16 -dpi 120 -alwaysshared -localhost %i\nExecStop=/usr/bin/vncserver -kill %i\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/vncserver@:1.service'

