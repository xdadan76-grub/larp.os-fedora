
#!/bin/bash
set -Eeuo pipefail

# larp.os-fedora
# Image configuration

systemctl enable NetworkManager.service
systemctl enable firewalld.service
systemctl enable bluetooth.service
systemctl enable sddm.service

systemctl set-default graphical.target

# Enable Flathub when Flatpak is installed
if command -v flatpak >/dev/null 2>&1; then
    flatpak remote-add --system --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi
