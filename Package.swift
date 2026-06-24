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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.0.0-alpha.1/YunoSDK_SPM.xcframework.zip",
            checksum: "8e1e8dd56dad32e3dec8e58e8e1c4326fd70b6e204e4c2e545767e1b65a9495b"
        )
    ]
)
