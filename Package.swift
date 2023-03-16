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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.12/YunoSDK_SPM.xcframework.zip",
            checksum: "11f7ef51152a2a8f905cce5b4d944c9c37875e2a2ad41eea81808ac13e450217"
        )
    ]
)
