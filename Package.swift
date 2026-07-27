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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.21.0/YunoSDK_SPM.xcframework.zip",
            checksum: "85e2df7b2f3830479961eaddfa76e55d2d56a46d0b7e99d7dabb9ba1156962d2"
        )
    ]
)
