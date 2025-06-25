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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.2.0/YunoSDK_SPM.xcframework.zip",
            checksum: "189b4dc188fa2499ed34907b49c23a5d19107083b8ade00671273e653ddabf55"
        )
    ]
)
