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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.22.0/YunoSDK_SPM.xcframework.zip",
            checksum: "b96b2ddb821e71417ac10013f8517e862f765290d453a6b0b7379a03bcd1e784"
        )
    ]
)
