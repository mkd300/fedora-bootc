#!/usr/bin/env bash

set -euo pipefail

PACKAGES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

mapfile -t PACKAGES < <(
    grep -hEv '^[[:space:]]*(#|$)' "$PACKAGES_DIR"/*.txt | sort -u
)

if ((${#PACKAGES[@]} == 0)); then
    printf 'ERROR: No packages found.\n' >&2
    exit 1
fi

dnf5 install -y "${PACKAGES[@]}"
dnf5 clean all
