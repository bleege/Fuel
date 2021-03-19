// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Fuel",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Fuel",
            targets: ["Fuel"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/CombineCommunity/CombineCocoa.git", .exact("0.1.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", .exact("2.7.1")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .exact("2.6.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Fuel",
            dependencies: ["CombineCocoa", "Swinject", "SwinjectAutoregistration"],
            path: "./Fuel",
            exclude: ["Info.plist"],
            resources: [
                .copy("Fuel.entitlements"),
                .copy("2016-VW-Jetta-Fuel-Tracking.csv")
            ]),
        .testTarget(
            name: "FuelTests",
            dependencies: ["Fuel"],
            path: "./FuelTests",
            exclude: ["Info.plist"]
            )
    ]
)
