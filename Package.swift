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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.9.1/YunoSDK_SPM.xcframework.zip",
            checksum: "4fcc157c6b2e8d0c10c211cce880e89a3e17277f0f7e1f9701a8d6db603a7b9a"
        )
    ]
)
