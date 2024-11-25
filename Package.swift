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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.21.0/YunoSDK_SPM.xcframework.zip",
            checksum: "8e6d2259512b9f912cd6a107118245672fc5ff210ec8de8ac2fdd5c8b3d310a1"
        )
    ]
)
