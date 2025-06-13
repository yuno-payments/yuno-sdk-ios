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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.24.3/YunoSDK_SPM.xcframework.zip",
            checksum: "77aa0172a30042f06a3e0f17cb4dd0836a343f6f4f0de1bd252ce89368ee6167"
        )
    ]
)
