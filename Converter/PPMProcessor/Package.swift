// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PPMProcessor",
    products: [
        .library(name: "PPM.Reader.Plugin", type: .dynamic, targets: ["PPM.Reader"]),
        .library(name: "PPM.Writer.Plugin", type: .dynamic, targets: ["PPM.Writer"])
    ],
    dependencies: [
        .package(url: "https://github.com/Lastivky/PluginBuilder.git", branch: "test")
    ],
    targets: [
        .target(name: "PPM.Core"),
        .target(name: "PPM.Reader", dependencies: [
            .product(name: "PluginInterface", package: "PluginBuilder"),
            "PPM.Core"
        ]),
        .target(name: "PPM.Writer", dependencies: [
            .product(name: "PluginInterface", package: "PluginBuilder"),
            "PPM.Core"
        ])
    ]
)
