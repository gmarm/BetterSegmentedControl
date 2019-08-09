// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BetterSegmentedControl",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "BetterSegmentedControl", targets: ["BetterSegmentedControl"])
    ],
    targets: [
        .target(name: "BetterSegmentedControl", path: "Pod"),
    ]
)
