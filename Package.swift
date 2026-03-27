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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.14.0/YunoSDK_SPM.xcframework.zip",
            checksum: "4746bb94e674ef78b6ef23f053d99fa5581b7f3d434c356641f4b29e727fc01b"
        )
    ]
)
