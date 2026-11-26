
# larp.os-fedora Build System

## Image Builder

KIWI NG.

## Target

- Fedora Linux 45
- KDE Plasma
- x86_64
- Live ISO
- Graphical installer

## Build requirements

- Fedora Linux build environment
- KIWI NG
- Git
- QEMU for virtual testing
- At least 15 GB of free disk space

## Official Fedora source

https://forge.fedoraproject.org/releng/kiwi-descriptions

## Build policy

1. Use the official Fedora image descriptions.
2. Keep larp.os-fedora customizations separate.
3. Validate package availability.
4. Check the image configuration.
5. Build the ISO.
6. Test booting in a virtual machine.
7. Verify the final ISO.

## Current status

Build pipeline under development.

The build scripts are intentionally disabled
until the image definition is validated.
