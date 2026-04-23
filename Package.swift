// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppDesignSystem",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "AppDesignSystem",
            targets: ["AppDesignSystem"]
        )
    ],
    targets: [
        .target(
            name: "AppDesignSystem"
        ),
        .testTarget(
            name: "AppDesignSystemTests",
            dependencies: ["AppDesignSystem"]
        )
    ]
)
