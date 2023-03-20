// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsApplication",
    products: [
        .library(
            name: "NewsApplication",
            targets: ["NewsApplication"]),
        .library(
            name: "Utility",
            targets: ["Utility"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NewsApplication",
            dependencies: []),
        .target(
            name: "Utility",
            dependencies: []),
    ]
)
