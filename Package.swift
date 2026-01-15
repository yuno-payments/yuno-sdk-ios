// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.11.0-beta/YunoSDK_SPM.xcframework.zip",
            checksum: "1402d12d29deefcdb26da284969a3b95987148d5016e19f474d3aad4a86cf1e4"
        )
    ]
)
