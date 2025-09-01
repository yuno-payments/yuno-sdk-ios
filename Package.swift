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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.5.0-beta.1/YunoSDK_SPM.xcframework.zip",
            checksum: "7b594419c770e6e1f5d66b0c1429ff8451dc247557547dae70062ba04c0b75e8"
        )
    ]
)
