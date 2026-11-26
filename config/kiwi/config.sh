
#!/usr/bin/env bash
set -Eeuo pipefail

# larp.os-fedora
# KIWI image configuration

echo "Configuring larp.os-fedora..."

# Enable graphical startup
systemctl --root=/ enable graphical.target

# Enable NetworkManager if installed
if [[ -f /usr/lib/systemd/system/NetworkManager.service ]]; then
    systemctl --root=/ enable NetworkManager.service
fi

# Enable SDDM if installed
if [[ -f /usr/lib/systemd/system/sddm.service ]]; then
    systemctl --root=/ enable sddm.service
fi

# Enable firewall if installed
if [[ -f /usr/lib/systemd/system/firewalld.service ]]; then
    systemctl --root=/ enable firewalld.service
fi

echo "larp.os-fedora configuration completed."
