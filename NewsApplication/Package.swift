// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsApplication",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Utility",
            targets: ["Utility"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Models",
            targets: ["Models"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Utility",
            dependencies: []),
        .target(
            name: "Networking",
            dependencies: []),
        .target(
            name: "Models",
            dependencies: ["Utility"]),
    ]
)
