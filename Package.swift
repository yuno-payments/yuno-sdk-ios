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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.0.0/YunoSDK_SPM.xcframework.zip",
            checksum: "525067e26507958de37ea6fab4e1f62d7a35f4023cb9e6c1d8016f2fe2a82cfa"
        )
    ]
)
