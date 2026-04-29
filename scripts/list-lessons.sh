#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root_dir="$(cd "$script_dir/.." && pwd)"

find "$root_dir/lessons" -maxdepth 1 -type f -name "*.md" -print | sort
