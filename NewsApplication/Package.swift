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
        .library(
            name: "Service",
            targets: ["Service"]),
        .library(
            name: "ListFeature",
            targets: ["ListFeature"]),
        .library(
            name: "DetailsFeature",
            targets: ["DetailsFeature"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Utility",
            dependencies: []),
        .target(
            name: "Networking",
            dependencies: ["Utility"]),
        .target(
            name: "Models",
            dependencies: ["Utility"]),
        .target(
            name: "Service",
            dependencies: ["Networking", "Models"]),
        .target(
            name: "ListFeature",
            dependencies: ["Service"]),
        .target(
            name: "DetailsFeature",
            dependencies: ["Utility", "Models"])
    ]
)
