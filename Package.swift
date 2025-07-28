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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.2.2/YunoSDK_SPM.xcframework.zip",
            checksum: "af78e0fa0eb44bd34d324c4a3c8559f6d96755f0ce98c3465f608c99e0b917c2"
        )
    ]
)
