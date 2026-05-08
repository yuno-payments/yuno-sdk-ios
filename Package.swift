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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.16.0/YunoSDK_SPM.xcframework.zip",
            checksum: "99d7a4e7bff2b6627acea906294b00f1de5dc176b5ed5892f08cf261bd94e1aa"
        )
    ]
)
