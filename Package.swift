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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.4/YunoSDK_SPM.xcframework.zip",
            checksum: "291cefdc8f4ec560efb2c9ebed07684c5a2bd1843d0f0eca70ad49fc5d0d205e"
        )
    ]
)
