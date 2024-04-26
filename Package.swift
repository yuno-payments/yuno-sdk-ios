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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.9.0/YunoSDK_SPM.xcframework.zip",
            checksum: "34a852eb3f2b6cfccec9e3e03f2b654d54a1a8f9ac2ba8c8b88d7fcc7727061a"
        )
    ]
)
