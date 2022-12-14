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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.2/YunoSDK_SPM.xcframework.zip",
            checksum: "66c0d6b7d9ed340a30502cd39f5c5427df035998dcd9a7e15e4a7f8c9a56286b"
        )
    ]
)
