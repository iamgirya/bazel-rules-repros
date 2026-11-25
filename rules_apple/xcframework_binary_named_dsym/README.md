# rules_apple: a dSYM named after the framework binary is dropped from an XCFramework import

`make_xcframework.sh` builds `Greeting.xcframework` for the iOS simulator with
`xcodebuild -create-xcframework -debug-symbols`. Its dSYM is named after the framework binary,
`dSYMs/Greeting.dSYM`, as in the WebRTC XCFramework we use, not after the framework
(`Greeting.framework.dSYM`). `//:app` imports it with `apple_dynamic_xcframework_import` and is
built with `--apple_generate_dsym`.

## Running

```sh
./run.sh
```

With rules_apple 5.4.0 from BCR the `dsyms` output group has only the app's dSYM:

```
app.app.dSYM/Contents/Resources/DWARF/app
app.app.dSYM/Contents/Info.plist
```

The same XCFramework with the dSYM named `Greeting.framework.dSYM`
(`./make_xcframework.sh Greeting.framework.dSYM`, then the `bazel cquery` from `run.sh`) also lists
`Greeting.xcframework/ios-arm64-simulator/dSYMs/Greeting.framework.dSYM/...`.

To try a local checkout instead of the release:

```sh
./run.sh /path/to/rules_apple
```

With dSYMs of any name imported it lists `Greeting.xcframework/ios-arm64-simulator/dSYMs/Greeting.dSYM/...`
as well.

Checked with Bazel 9.3.3, Xcode 26.2, macOS 15.7.
