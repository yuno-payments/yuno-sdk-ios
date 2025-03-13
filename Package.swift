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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.23.0/YunoSDK_SPM.xcframework.zip",
            checksum: "69b33236e8bda9bca3a8d451027bee76373b042f68f3b49052e82cf9adaddb11"
        )
    ]
)
