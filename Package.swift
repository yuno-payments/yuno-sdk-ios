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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.12.8-RC/YunoSDK_SPM.xcframework.zip",
            checksum: "e2170260952d93243ebe86fb0f7de5947324e4dae991239d3b5b2625e5d06045"
        )
    ]
)
