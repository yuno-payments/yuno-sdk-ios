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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.25.0/YunoSDK_SPM.xcframework.zip",
            checksum: "cd8b02a913653b0776dde9b4f7509968f13090e08e05538dcb2e939185788e8b"
        )
    ]
)
