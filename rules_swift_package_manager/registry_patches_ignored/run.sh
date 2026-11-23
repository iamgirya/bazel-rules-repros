#!/usr/bin/env bash
# Builds and runs //:main. Pass a rules_swift_package_manager checkout to test it
# instead of the BCR release: ./run.sh /path/to/rules_swift_package_manager
set -euo pipefail
cd "$(dirname "$0")"

args=()
if [[ $# -gt 0 ]]; then
  args+=("--override_module=rules_swift_package_manager=$(cd "$1" && pwd)")
fi

bazel run "${args[@]+"${args[@]}"}" //:main
