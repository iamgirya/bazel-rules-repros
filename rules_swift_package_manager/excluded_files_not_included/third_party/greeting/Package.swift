// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "greeting",
    products: [
        .library(name: "CGreeting", targets: ["CGreeting"]),
    ],
    targets: [
        .target(
            name: "CGreeting",
            // Not compiled on their own, only #included by greeting.c.
            exclude: ["greeting_prefix.h", "greeting_table.c"]
        ),
    ]
)
