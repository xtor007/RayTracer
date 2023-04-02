// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BMPProcessor",
    products: [
        .library(name: "BMP.Reader.Plugin", type: .dynamic, targets: ["BMP.Reader"]),
        .library(name: "BMP.Writer.Plugin", type: .dynamic, targets: ["BMP.Writer"])
    ],
    dependencies: [
        .package(url: "https://github.com/Lastivky/PluginBuilder.git", branch: "test")
    ],
    targets: [
        .target(name: "BMP.Core"),
        .target(name: "BMP.Reader", dependencies: [
            .product(name: "PluginInterface", package: "PluginBuilder"),
            "BMP.Core"
        ]),
        .target(name: "BMP.Writer", dependencies: [
            .product(name: "PluginInterface", package: "PluginBuilder"),
            "BMP.Core"
        ])
    ]
)
