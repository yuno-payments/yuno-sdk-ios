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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.19.0/YunoSDK_SPM.xcframework.zip",
            checksum: "7e87d6f16dd371d9e0e917b81058ec7312cb65933266e4df4b4d52c6e0dfbced"
        )
    ]
)
