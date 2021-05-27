// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrimeExplorerCore",

    platforms: [
        .macOS(.v11), .iOS(.v14), .tvOS(.v14), .watchOS(.v7)
    ],

    products: [
        .library(
            name: "CrimeExplorerCore",
            targets: ["CrimeExplorerCore"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/adamayoung/UKPoliceData.git", .branch("main"))
    ],

    targets: [
        .target(
            name: "CrimeExplorerCore",
            dependencies: ["UKPoliceData"]
        ),

        .testTarget(
            name: "CrimeExplorerCoreTests",
            dependencies: ["CrimeExplorerCore"]
        )
    ]
)
