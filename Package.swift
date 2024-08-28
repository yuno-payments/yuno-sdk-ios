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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.15.0/YunoSDK_SPM.xcframework.zip",
            checksum: "cdbac4ab6335a4f59705ee62eec114c6c566a90b8d37a92e0aa8c8672f913f71"
        )
    ]
)
