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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.1/YunoSDK_SPM.xcframework.zip",
            checksum: "4e67c9a0edc3ffc7d24e58872ac9b065207d7d0e5205b9e7e5812c6ff3ae6dd0"
        )
    ]
)
