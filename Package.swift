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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.3.0/YunoSDK_SPM.xcframework.zip",
            checksum: "dd016f469de6e3b7b0df0f1a08b65d4a9c70139f49a646f025dd1f4e7b4f4582"
        )
    ]
)
