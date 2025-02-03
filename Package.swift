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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.21.2/YunoSDK_SPM.xcframework.zip",
            checksum: "7d8339b6c93c5e4c09539f75d2efe73520a1766dbf2269acf67c628dfa01c6a3"
        )
    ]
)
