// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.0/YunoSDK.xcframework.zip",
            checksum: "75de5b746897ca966489e6f065b1a7d5f7547f4d5d6678eb51fcea9a4b114737"
        )
    ]
)
