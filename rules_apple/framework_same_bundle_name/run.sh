#!/usr/bin/env bash
# Builds both frameworks. Pass a rules_apple checkout to test it instead of the
# BCR release: ./run.sh /path/to/rules_apple
set -euo pipefail
cd "$(dirname "$0")"

args=()
if [[ $# -gt 0 ]]; then
  args+=("--override_module=rules_apple=$(cd "$1" && pwd)")
fi

bazel build "${args[@]+"${args[@]}"}" //:app_framework_free //:app_framework_paid
