// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConverterCore",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "ImageCreator", targets: ["ImageCreator"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", branch: "main"),
        .package(url: "https://github.com/Lastivky/PluginBuilder.git", branch: "test")
    ],
    targets: [
        .target(name: "ConverterCore", dependencies: [
            .product(name: "PluginInterface", package: "PluginBuilder")
        ]),
        .executableTarget(name: "CLI", dependencies: [
            "ConverterCore",
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .target(name: "ImageCreator", dependencies: [
            "ConverterCore",
            .product(name: "PluginInterface", package: "PluginBuilder")
        ])
    ]
)
