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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.12.2/YunoSDK_SPM.xcframework.zip",
            checksum: "def0fe1528791b5939e0c23e847b995f464bf01bcb050c351384e89a4c82c955"
        )
    ]
)
