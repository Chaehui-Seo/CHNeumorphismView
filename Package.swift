// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CHNeumorphismView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "CHNeumorphismView",
            targets: ["CHNeumorphismView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CHNeumorphismView",
            dependencies: []),
    ]
)
