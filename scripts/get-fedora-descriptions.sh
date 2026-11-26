
#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

REPO="https://forge.fedoraproject.org/releng/kiwi-descriptions.git"
DEST="$ROOT_DIR/build/fedora-kiwi-descriptions"

if ! command -v git >/dev/null 2>&1; then
    echo "ERROR: Git is required."
    exit 1
fi

if [[ -d "$DEST/.git" ]]; then
    echo "Fedora descriptions already downloaded."
    exit 0
fi

if [[ -e "$DEST" ]]; then
    echo "ERROR: Destination already exists."
    exit 1
fi

git clone "$REPO" "$DEST"

echo "Fedora descriptions downloaded."
echo "Review the Fedora 45 branch before building."
