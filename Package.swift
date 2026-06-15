// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ScoopCardlink",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "ScoopCardlink", targets: ["ScoopCardlink"])
    ],
    targets: [
        .binaryTarget(
            name: "ScoopCardlink",
            url: "https://github.com/scoop-software/cardlink-sdk-spm/releases/download/v2.2.0/ScoopCardlink.xcframework.zip",
            checksum: "c4b7949226d527586a532ae9264646043fd386a399a42c8991a303169a0138bf"
        )
    ]
)
