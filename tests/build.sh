#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

IMAGE="localhost/fedora-bootc:44"

sudo podman build \
    -t "$IMAGE" \
    "$PROJECT_DIR"
