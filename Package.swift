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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.13.0/YunoSDK_SPM.xcframework.zip",
            checksum: "f2f881f1a6cacc62cfa7a821bc9301cecf1fd8483e437e2109a2eccac0a88d40"
        )
    ]
)
