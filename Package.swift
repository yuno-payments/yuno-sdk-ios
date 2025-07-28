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
            checksum: "222b028c2724b56b94524382104323197d7b36ffbd5da238adf92f27ed508e79"
        )
    ]
)
