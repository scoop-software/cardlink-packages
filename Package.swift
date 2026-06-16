// swift-tools-version: 5.9
import PackageDescription

// One public Swift Package hosting all Scoop SDK XCFrameworks. The SDK sources stay
// private; only these binaries (attached to the matching GitHub Release) are public.
//   ScoopCardlink — CardLink flow (statically links NFC + PoPP internally)
//   ScoopNfc / ScoopNfcUI — NFC SDK (core + SwiftUI views)
//   ScoopPopp — PoPP module
let package = Package(
    name: "CardlinkPackages",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "ScoopCardlink", targets: ["ScoopCardlink"]),
        .library(name: "ScoopNfc", targets: ["ScoopNfc"]),
        .library(name: "ScoopNfcUI", targets: ["ScoopNfcUI"]),
        .library(name: "ScoopPopp", targets: ["ScoopPopp"]),
    ],
    targets: [
        .binaryTarget(
            name: "ScoopCardlink",
            url: "https://github.com/scoop-software/cardlink-packages/releases/download/v2.2.0/ScoopCardlink.xcframework.zip",
            checksum: "c4b7949226d527586a532ae9264646043fd386a399a42c8991a303169a0138bf"
        ),
        .binaryTarget(
            name: "ScoopNfc",
            url: "https://github.com/scoop-software/cardlink-packages/releases/download/v2.2.0/ScoopNfc.xcframework.zip",
            checksum: "3367a1659f5623e7ae982415bc9348f55869a46409ceaf37002dc39adc9f1470"
        ),
        .binaryTarget(
            name: "ScoopNfcUI",
            url: "https://github.com/scoop-software/cardlink-packages/releases/download/v2.2.0/ScoopNfcUI.xcframework.zip",
            checksum: "df885f5806c755fdba497c946c22ac1725c1b866094ca737b308a2450bfaaa01"
        ),
        .binaryTarget(
            name: "ScoopPopp",
            url: "https://github.com/scoop-software/cardlink-packages/releases/download/v2.2.0/ScoopPopp.xcframework.zip",
            checksum: "bb0cce9fb97b7307f97fa650b50db9cf3ebca0abcede504890459278ee2fc786"
        ),
    ]
)
