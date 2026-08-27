// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.23.0/YunoSDK_SPM.xcframework.zip",
            checksum: "93dd88955f230a9bc68c25324a6a294546eb9df3e687c1308aeea162f583f6c2"
        )
    ]
)
