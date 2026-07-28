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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.21.1/YunoSDK_SPM.xcframework.zip",
            checksum: "6ecad782e31954dfd6957c364990fce661fa244b5c5dce121aa8b53ac2df0bf7"
        )
    ]
)
