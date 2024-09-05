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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.13.3/YunoSDK_SPM.xcframework.zip",
            checksum: "4c5f698673a507173f24a922c118d1d3367d2bf23b0dfb9b1993a4c9464d360f"
        )
    ]
)
