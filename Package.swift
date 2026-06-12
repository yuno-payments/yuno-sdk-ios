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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.18.0/YunoSDK_SPM.xcframework.zip",
            checksum: "a6a5f894c185c6c3698efa315725eef0801a14a70c8cc32f0f4cd4b2fedcd063"
        )
    ]
)
