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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.11/YunoSDK_SPM.xcframework.zip",
            checksum: "ce2617b725134b171faa35979da0a62ba20609e2f8ddb7bd13110d7e221de1a9"
        )
    ]
)
