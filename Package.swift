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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.8.1/YunoSDK_SPM.xcframework.zip",
            checksum: "b1eb8edbdf26ce78e2796de1645e84f27b9ed4c5d157c5fb1cb51572cbc7f66e"
        )
    ]
)
