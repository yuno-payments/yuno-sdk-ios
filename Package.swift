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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.4.2/YunoSDK_SPM.xcframework.zip",
            checksum: "8c972607444d48cbee999ef7e15612de8b7659eb4ef9174be9a542f61a947405"
        )
    ]
)
