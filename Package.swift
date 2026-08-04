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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.21.1/YunoSDK_SPM.xcframework.zip",
            checksum: "a6393c357ab31351d2ff953171cfe2cda93d6dae22366d81b99e2508c0d5d472"
        )
    ]
)
