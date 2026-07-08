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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.20.0/YunoSDK_SPM.xcframework.zip",
            checksum: "6ef2f2a88e5b411a9dc9530cff6b38501d244cbe487faee59ec6b4740db96d75"
        )
    ]
)
