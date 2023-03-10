// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Flowers",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(name: "Flowers", targets: ["Flowers"])
    ],
    targets: [
        .target(name: "Flowers"),
        .testTarget(
            name: "FlowersTests",
            dependencies: ["Flowers"]
        )
    ]
)
