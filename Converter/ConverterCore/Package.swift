// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConverterCore",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", branch: "main"),
        .package(url: "https://github.com/Lastivky/PluginBuilder.git", branch: "test")
    ],
    targets: [
        .executableTarget(name: "ConverterCore", dependencies: [
            .product(name: "PluginInterface", package: "PluginBuilder"),
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ])
    ]
)
