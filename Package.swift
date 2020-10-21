// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BetterSegmentedControl",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "BetterSegmentedControl",
            targets: ["BetterSegmentedControl"]
        )
    ],
    targets: [
        .target(
            name: "BetterSegmentedControl",
            path: "Pod/Classes"
        )
    ],
    swiftLanguageVersions: [.v5]
)
