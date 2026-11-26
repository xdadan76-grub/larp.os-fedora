
#!/usr/bin/env bash
set -Eeuo pipefail

REPO="https://forge.fedoraproject.org/releng/fedora-kiwi-descriptions"
DEST="build/fedora-kiwi-descriptions"

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -e "$ROOT_DIR/$DEST" ]]; then
    echo "Fedora descriptions already exist."
    echo "No files were changed."
    exit 0
fi

mkdir -p "$ROOT_DIR/build"

git clone "$REPO" "$ROOT_DIR/$DEST"

echo "Fedora image descriptions downloaded."
echo "Review the Fedora 45 definitions before using them."
