#!/usr/bin/env bash
# Creates Greeting.xcframework and prints the dsyms output group of //:app.
# Pass a rules_apple checkout to test it instead of the BCR release:
# ./run.sh /path/to/rules_apple
set -euo pipefail
cd "$(dirname "$0")"

args=()
if [[ $# -gt 0 ]]; then
  args+=("--override_module=rules_apple=$(cd "$1" && pwd)")
fi

./make_xcframework.sh
bazel cquery "${args[@]+"${args[@]}"}" //:app --output=starlark \
  --starlark:expr='"\n".join([f.short_path for f in providers(target)["OutputGroupInfo"].dsyms.to_list()])'
