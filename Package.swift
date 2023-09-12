// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Money",
    platforms: [
        .macOS(.v13),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "Money",
            targets: ["Money"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Money",
            dependencies: []),
        .testTarget(
            name: "MoneyTests",
            dependencies: ["Money"]),
    ]
)
