
#!/usr/bin/env bash
set -Eeuo pipefail

# larp.os-fedora
# System configuration script

PROJECT="larp.os-fedora"

echo "=================================="
echo " Configuring $PROJECT"
echo "=================================="

if [[ "$EUID" -ne 0 ]]; then
    echo "ERROR: Run with sudo."
    exit 1
fi

echo "[1/5] Updating system..."
dnf upgrade --refresh -y

echo "[2/5] Enabling NetworkManager..."
systemctl enable NetworkManager.service

echo "[3/5] Enabling Bluetooth..."
if systemctl list-unit-files bluetooth.service >/dev/null 2>&1; then
    systemctl enable bluetooth.service
fi

echo "[4/5] Enabling firewall..."
systemctl enable --now firewalld.service

echo "[5/5] Configuring Flatpak..."
if command -v flatpak >/dev/null 2>&1; then
    flatpak remote-add --system --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo
else
    echo "Flatpak is not installed. Skipping."
fi

echo "=================================="
echo "$PROJECT configuration finished."
echo "=================================="
