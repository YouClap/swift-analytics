// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Analytics",
    products: [
        .library(name: "Analytics",targets: ["Analytics"]),
    ],
    targets: [
        .target(name: "Analytics", path: "Sources", exclude: ["Analytics.xcodeproj", "README.md", "LICENSE"]),
        .testTarget(name: "AnalyticsTests", dependencies: ["Analytics"], path: "Tests"),
    ]
)
