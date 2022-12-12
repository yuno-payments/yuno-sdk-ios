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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.1/YunoSDK.xcframework.zip",
            checksum: "1014616a014bb15f32b896291bd8f8444b9390356cb201bfb33da576bb895ad6"
        )
    ]
)
