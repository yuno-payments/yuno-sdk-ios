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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.21.3-rc/YunoSDK_SPM.xcframework.zip",
            checksum: "abc758522e9932e17b6708c0243402b8a835631e0018606ea5115f202df3d1ca"
        )
    ]
)
