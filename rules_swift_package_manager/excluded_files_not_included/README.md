# rules_swift_package_manager: excluded files of a C target are missing from the build

SwiftPM's `exclude` only keeps a file from being compiled on its own. The file stays in the
package, and other sources of the target can still `#include` it. rules_swift_package_manager
adds headers from excluded directories back to the target, but leaves excluded files out.

`third_party/greeting` is a local package with a C target that excludes `greeting_prefix.h`
and `greeting_table.c` and `#include`s both from `greeting.c`. `swift build` in
`third_party/greeting` builds it.

## Running

```sh
./run.sh
```

With rules_swift_package_manager 1.26.0 from BCR:

```
Sources/CGreeting/greeting.c:2:10: fatal error: 'greeting_prefix.h' file not found
```

To try a local checkout instead of the release:

```sh
./run.sh /path/to/rules_swift_package_manager
```

With excluded files kept for `#include` it prints `excluded files are available to #include`.

Checked with Bazel 9.3.3, Xcode 26.2, macOS 15.7.
