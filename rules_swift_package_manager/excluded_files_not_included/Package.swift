// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "excluded_files_repro",
    dependencies: [
        .package(path: "third_party/greeting"),
    ]
)
