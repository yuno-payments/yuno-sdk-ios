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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.20.0/YunoSDK_SPM.xcframework.zip",
            checksum: "42e6b1898b736048da16bee4dd8fb063c47a7f396bb57576ceea31127779c131"
        )
    ]
)
