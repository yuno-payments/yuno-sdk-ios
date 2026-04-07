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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.14.2/YunoSDK_SPM.xcframework.zip",
            checksum: "fe834cc6485498dc071da55a190c9cfc7d617c451bd70072085c6aa6dd3e3751"
        )
    ]
)
