#!/usr/bin/env bash

set -euo pipefail

PACKAGES_TO_INSTALL=()
SERVICES_TO_ENABLE=()

for module_file in /tmp/image/modules/*.sh; do
    [[ -f "$module_file" ]] || continue

    source "$module_file"
done

if ((${#PACKAGES_TO_INSTALL[@]})); then
    dnf -y install "${PACKAGES_TO_INSTALL[@]}"
fi

if ((${#SERVICES_TO_ENABLE[@]})); then
    systemctl enable "${SERVICES_TO_ENABLE[@]}"
fi

systemctl set-default graphical.target

dnf clean all

find /var/log -type f ! -empty -delete

rm -rf /run/dnf /var/cache/* /var/lib/dnf/repos
