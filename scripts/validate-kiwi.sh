
#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KIWI_DIR="$ROOT_DIR/config/kiwi"

ERRORS=0

echo "================================"
echo " larp.os-fedora KIWI Validator"
echo "================================"

if [[ ! -f "$KIWI_DIR/config.xml" ]]; then
    echo "[ERROR] config.xml missing"
    ((ERRORS+=1))
else
    echo "[OK] config.xml exists"

    if command -v python3 >/dev/null 2>&1; then
        if python3 -c 'import sys, xml.etree.ElementTree as ET; ET.parse(sys.argv[1])' \
            "$KIWI_DIR/config.xml"; then
            echo "[OK] XML syntax valid"
        else
            echo "[ERROR] Invalid XML"
            ((ERRORS+=1))
        fi
    else
        echo "[WARNING] Python 3 unavailable; XML not checked"
    fi
fi

if [[ -f "$KIWI_DIR/config.sh" ]]; then
    if bash -n "$KIWI_DIR/config.sh"; then
        echo "[OK] config.sh syntax valid"
    else
        echo "[ERROR] config.sh syntax invalid"
        ((ERRORS+=1))
    fi
else
    echo "[WARNING] config.sh missing"
fi

echo "================================"

if (( ERRORS > 0 )); then
    echo "VALIDATION FAILED"
    exit 1
fi

echo "BASIC VALIDATION PASSED"
echo "This does not certify that the ISO can build."

