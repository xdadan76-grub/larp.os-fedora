
# larp.os-fedora — KIWI Image Builder

## Target system

- Distribution: larp.os-fedora
- Base: Fedora Linux 45
- Architecture: x86_64
- Desktop: KDE Plasma
- Image goal: Bootable Live ISO
- Installer: Anaconda

## Build technology

The project uses KIWI NG and Fedora image descriptions.

## Project requirements

- Custom larp.os-fedora branding
- KDE Plasma desktop
- NetworkManager
- PipeWire audio
- Firefox
- Flatpak support
- Graphical installation
- UEFI boot support

## Important

The image definition must be based on
Fedora's official KIWI descriptions.

Do not use the old Lorax build script
as the main image builder.

## Status

Under development.
