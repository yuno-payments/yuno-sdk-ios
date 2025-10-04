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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.7.0/YunoSDK_SPM.xcframework.zip",
            checksum: "f0f1288bdaddb0fadeee4d06f8553848aef5523e08050416a4cb579b9c8869bb"
        )
    ]
)
