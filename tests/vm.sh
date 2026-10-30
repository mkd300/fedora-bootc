#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

IMAGE="localhost/fedora-bootc:44"
OUTPUT_DIR="$HOME/Downloads"
OUTPUT_NAME="fedora-bootc-44-test"

mkdir -p "$OUTPUT_DIR"

BLUEPRINT="$(mktemp --suffix=.toml)"
trap 'rm -f "$BLUEPRINT"' EXIT

cat > "$BLUEPRINT" <<-'EOF'
    [[customizations.user]]
    name = "brendo"
    password = "2002"
    groups = ["wheel"]
EOF

sudo podman build \
    -t "$IMAGE" \
    "$PROJECT_DIR"

sudo image-builder build \
    --bootc-ref "$IMAGE" \
    --bootc-default-fs ext4 \
    --blueprint "$BLUEPRINT" \
    --output-dir "$OUTPUT_DIR" \
    --output-name "$OUTPUT_NAME" \
    qcow2

sudo chown "$(id -u):$(id -g)" \
    "$OUTPUT_DIR/$OUTPUT_NAME.qcow2"
