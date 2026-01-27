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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.11.0/YunoSDK_SPM.xcframework.zip",
            checksum: "8ae1185a59528c7f3556da8868bb0799198714e2fce337a3efd5c79b2953d7c9"
        )
    ]
)
