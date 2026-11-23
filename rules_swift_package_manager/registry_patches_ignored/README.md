# rules_swift_package_manager: `configure_package` patches are ignored for registry packages

`swift_deps.configure_package(patches = ...)` works for packages pinned from git, but a
package that comes from a Swift package registry is fetched unpatched, with no error or
warning.

This workspace depends on `apple.swift-collections` 1.1.3 from the registry that
`examples/swift_package_registry_example` of rules_swift_package_manager uses, and patches
a public enum into the `Collections` module. `main.swift` prints it.

## Running

```sh
./run.sh
```

With rules_swift_package_manager 1.26.0 from BCR:

```
main.swift:4:25: error: cannot find 'CollectionsPatchMarker' in scope
```

To try a local checkout instead of the release:

```sh
./run.sh /path/to/rules_swift_package_manager
```

With the patch attributes forwarded to the registry package it prints `patch applied: true`.

Checked with Bazel 9.3.3, Xcode 26.2, macOS 15.7.
