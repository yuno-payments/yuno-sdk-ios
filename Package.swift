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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.14.1/YunoSDK_SPM.xcframework.zip",
            checksum: "c448c9a44fc1eff853b4e0d59f11e50de9a60e517c0f1cd8971063e17f5fa4ea"
        )
    ]
)
