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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.12.3/YunoSDK_SPM.xcframework.zip",
            checksum: "6d8cf4d2c16adbb67587b8ff78a09493ab75920adc9d9cb5de3623ac26ee38cb"
        )
    ]
)
