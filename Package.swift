// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.19.2/YunoSDK_SPM.xcframework.zip",
            checksum: "1a2e6dc472e68196ef6941826984028eeb9f885ea1b2d572b7d07f944c2ea3cc"
        )
    ]
)
