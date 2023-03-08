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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.9/YunoSDK_SPM.xcframework.zip",
            checksum: "309e0fe40e03b1c6cf1ceb8d2bb19461193ffe02e071b47034d9a279ef128ee7"
        )
    ]
)
