
#!/usr/bin/env bash
set -Eeuo pipefail

# ==========================================
# larp.os-fedora System Validator
# ==========================================

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

ERRORS=0
WARNINGS=0

check_file() {
    if [[ -f "$ROOT_DIR/$1" ]]; then
        echo "[OK] $1"
    else
        echo "[ERROR] Missing: $1"
        ((ERRORS+=1))
    fi
}

check_directory() {
    if [[ -d "$ROOT_DIR/$1" ]]; then
        echo "[OK] $1"
    else
        echo "[ERROR] Missing directory: $1"
        ((ERRORS+=1))
    fi
}

echo "======================================"
echo "    larp.os-fedora System Validator"
echo "======================================"

echo ""
echo "[1] Checking project structure"

check_file "README.md"
check_file "config/kickstart/larp.ks"
check_file "config/packages/base.txt"
check_file "config/packages/desktop.txt"
check_file "config/packages/applications.txt"
check_file "build/build-iso.sh"
check_file "build/clean.sh"
check_directory "branding"
check_directory "desktop"
check_directory "installer"
check_directory "docs"
check_directory "tests"

echo ""
echo "[2] Checking Kickstart configuration"

KS="$ROOT_DIR/config/kickstart/larp.ks"

if [[ -f "$KS" ]]; then
    if grep -q '^%packages' "$KS"; then
        echo "[OK] Package section found"
    else
        echo "[WARNING] Kickstart package section missing"
        ((WARNINGS+=1))
    fi
fi

echo ""
echo "[3] Checking shell scripts"

while IFS= read -r -d '' script; do
    if bash -n "$script"; then
        echo "[OK] $(basename "$script")"
    else
        echo "[ERROR] Shell syntax error: $script"
        ((ERRORS+=1))
    fi
done < <(find "$ROOT_DIR/scripts" "$ROOT_DIR/build" \
    -type f -name "*.sh" -print0 2>/dev/null)

echo ""
echo "======================================"
echo "VALIDATION SUMMARY"
echo "======================================"

echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"

if (( ERRORS > 0 )); then
    echo "VALIDATION FAILED"
    exit 1
fi

echo "STRUCTURE VALIDATION PASSED"
echo "Package and ISO tests still required."
