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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.20.0/YunoSDK_SPM.xcframework.zip",
            checksum: "001ecc24f527de0d0cca5e447cc96d31264106b4215d99fea3af1ac99ef339ca"
        )
    ]
)
