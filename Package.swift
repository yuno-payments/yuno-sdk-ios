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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.2.2-logs/YunoSDK_SPM.xcframework.zip",
            checksum: "eb801145a1dde3ab7d17b9ad329cdb051283af9284446ec8fff5397212d6b2b2"
        )
    ]
)
