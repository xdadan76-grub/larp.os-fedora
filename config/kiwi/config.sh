
#!/usr/bin/env bash
set -Eeuo pipefail

echo "Configuring larp.os-fedora..."

systemctl --root=/ enable graphical.target

for service in \
    NetworkManager.service \
    sddm.service \
    firewalld.service \
    flatpak-flathub.service
do
    if systemctl --root=/ enable "$service"; then
        echo "[OK] Enabled $service"
    else
        echo "[WARNING] Could not enable $service"
    fi
done

echo "Configuration completed."
