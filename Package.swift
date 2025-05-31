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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.0.0/YunoSDK_SPM.xcframework.zip",
            checksum: "fe83bc528a0453984a6a3afed636e6330b120b1b6ae6222450a8afa96e54787b"
        )
    ]
)
