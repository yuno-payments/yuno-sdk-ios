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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.15.0/YunoSDK_SPM.xcframework.zip",
            checksum: "eda82943371fe6bdfc087d67aa78fd8e864a270ff87c00e599be2fec39be9632"
        )
    ]
)
