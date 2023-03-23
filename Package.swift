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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.14/YunoSDK_SPM.xcframework.zip",
            checksum: "282e335c7f0b81508bdc04748d84bdbc09a064a58ca46f5c28a2e901b42c2c30"
        )
    ]
)
