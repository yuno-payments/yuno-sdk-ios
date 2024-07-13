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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.13.0/YunoSDK_SPM.xcframework.zip",
            checksum: "74d7a9736dc966f6073a3bd7fc073830f77f4b8e7dcfc66ba6ebe26d9dff83bd"
        )
    ]
)
