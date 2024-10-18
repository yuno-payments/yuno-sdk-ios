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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.18.0/YunoSDK_SPM.xcframework.zip",
            checksum: "347e0e24d67a2667fd36dd730433ecbe4ff320db7ebdbf7cd8650fb7d001f6b2"
        )
    ]
)
