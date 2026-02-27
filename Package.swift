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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.12.0/YunoSDK_SPM.xcframework.zip",
            checksum: "4f5e9cfc78723b4927b340879a578c5a35fa5d050182be0fc3f187cf693417e1"
        )
    ]
)
