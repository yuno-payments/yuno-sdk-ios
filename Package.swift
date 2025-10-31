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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.8.0/YunoSDK_SPM.xcframework.zip",
            checksum: "7edc872c986b6d59b7d66b92ee21ec4eb16fb1a63de402a85eb30c93322ebd1d"
        )
    ]
)
