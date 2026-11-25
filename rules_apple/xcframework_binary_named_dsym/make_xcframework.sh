#!/usr/bin/env bash
# Builds Greeting.xcframework for the iOS simulator with its dSYM named after the
# binary (dSYMs/Greeting.dSYM), not after the framework (Greeting.framework.dSYM).
# Pass a dSYM name to change it: ./make_xcframework.sh Greeting.framework.dSYM
set -euo pipefail
cd "$(dirname "$0")"

out=$(mktemp -d)
fw="$out/Greeting.framework"
mkdir -p "$fw"
sim_clang=(xcrun --sdk iphonesimulator clang -target arm64-apple-ios15.0-simulator)
"${sim_clang[@]}" -g -c greeting.c -o "$out/greeting.o"
"${sim_clang[@]}" -dynamiclib -install_name @rpath/Greeting.framework/Greeting \
  -o "$fw/Greeting" "$out/greeting.o"
cat > "$fw/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key><string>Greeting</string>
  <key>CFBundleIdentifier</key><string>com.example.greeting</string>
  <key>CFBundlePackageType</key><string>FMWK</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>CFBundleVersion</key><string>1</string>
  <key>MinimumOSVersion</key><string>15.0</string>
</dict>
</plist>
PLIST
dsym="${1:-Greeting.dSYM}"
xcrun dsymutil "$fw/Greeting" -o "$out/$dsym"

rm -rf Greeting.xcframework
xcodebuild -create-xcframework -framework "$fw" -debug-symbols "$out/$dsym" \
  -output Greeting.xcframework >/dev/null
rm -rf "$out"
