
#!/usr/bin/env bash
set -Eeuo pipefail

# ==========================================
# larp.os-fedora ISO Builder
# Base: Fedora KDE Spin
# Architecture: x86_64
# ==========================================

PROJECT_NAME="larp.os-fedora"
ISO_NAME="larp.os-fedora-x86_64.iso"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

KICKSTART="$ROOT_DIR/config/kickstart/larp.ks"
OUTPUT_DIR="$ROOT_DIR/build/output"

echo "======================================"
echo "       larp.os-fedora ISO Builder"
echo "======================================"

# Check arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: sudo $0 /path/to/fedora-installer.iso"
    exit 1
fi

SOURCE_ISO="$(realpath "$1")"

# Check root permissions
if [[ "$EUID" -ne 0 ]]; then
    echo "ERROR: Run this script with sudo."
    exit 1
fi

# Check source ISO
if [[ ! -f "$SOURCE_ISO" ]]; then
    echo "ERROR: Fedora installer ISO not found."
    exit 1
fi

# Check Kickstart
if [[ ! -f "$KICKSTART" ]]; then
    echo "ERROR: Kickstart file not found."
    exit 1
fi

# Check Kickstart package section
if ! grep -q '^%packages' "$KICKSTART"; then
    echo "ERROR: Kickstart has no %packages section."
    echo "Complete and validate larp.ks first."
    exit 1
fi

# Check build tool
if ! command -v livemedia-creator >/dev/null 2>&1; then
    echo "ERROR: livemedia-creator is not installed."
    echo "Install and configure Lorax on a Fedora build system."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "Project: $PROJECT_NAME"
echo "Source ISO: $SOURCE_ISO"
echo "Kickstart: $KICKSTART"
echo "Output: $OUTPUT_DIR"

echo "Starting ISO build..."

livemedia-creator \
    --make-iso \
    --iso="$SOURCE_ISO" \
    --ks="$KICKSTART" \
    --resultdir="$OUTPUT_DIR" \
    --iso-only \
    --iso-name="$ISO_NAME"

echo "======================================"
echo "ISO BUILD FINISHED"
echo "======================================"
echo "Check output directory:"
echo "$OUTPUT_DIR"
