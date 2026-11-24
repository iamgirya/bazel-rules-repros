"""Writes a Package.swift that depends on a local package next to it."""

def _generated_package_impl(repository_ctx):
    repository_ctx.file("BUILD.bazel", 'exports_files(["Package.swift"])\n')
    repository_ctx.file("Package.swift", """\
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "generated",
    dependencies: [
        .package(path: "greeting"),
    ]
)
""")
    repository_ctx.file("greeting/Package.swift", """\
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "greeting",
    products: [
        .library(name: "Greeting", targets: ["Greeting"]),
    ],
    targets: [
        .target(name: "Greeting"),
    ]
)
""")
    repository_ctx.file("greeting/Sources/Greeting/Greeting.swift", """\
public func greeting() -> String {
    "local packages from another repository are found"
}
""")

generated_package = repository_rule(implementation = _generated_package_impl)
