// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
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
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.9.0"),
    ],
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
            dependencies: [
                "Service",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture")]),
        .target(
            name: "DetailsFeature",
            dependencies: [
                "Utility",
                "Models",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture")])
    ]
)

