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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.0.0-clearsale/YunoSDK_SPM.xcframework.zip",
            checksum: "ab316400ebad878ace3b2bf3fd43df02df8ee675f24ff58b201e59e466fc29a3"
        )
    ]
)
