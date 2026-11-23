// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "registry_patches_repro",
    dependencies: [
        .package(id: "apple.swift-collections", exact: "1.1.3"),
    ]
)
