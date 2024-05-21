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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.10.0/YunoSDK_SPM.xcframework.zip",
            checksum: "8352d7db0302ed0a8b24ee2513f8582acbe904b1828559df20ddc1594e822f42"
        )
    ]
)
