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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.3.0/YunoSDK_SPM.xcframework.zip",
            checksum: "aef78a0f4593cbe90be02f202bd4dff664c2c8ca47d22ce925292e31e5a7e820"
        )
    ]
)
