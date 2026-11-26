#!/bin/bash
set -e

systemctl set-default graphical.target

systemctl enable sddm.service
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable flatpak-flathub.service