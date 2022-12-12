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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.1/YunoSDK_SPM.xcframework.zip",
            checksum: "c926bb3960833f329a0c76a921b6852c3078fb68e74b8094871733d8ab0c2ab7"
        )
    ]
)
