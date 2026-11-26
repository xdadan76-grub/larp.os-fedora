
#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT="larp.os-fedora"
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

echo "===================================="
echo "       $PROJECT"
echo "       Fedora 45 KDE"
echo "===================================="

echo "Build system: KIWI NG"
echo "Architecture: x86_64"
echo "Image type: Live ISO"

echo ""
echo "The build pipeline is not ready yet."
echo "Do not generate an ISO until validation"
echo "and image configuration are complete."

exit 1
