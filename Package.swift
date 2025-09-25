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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.6.0/YunoSDK_SPM.xcframework.zip",
            checksum: "4e0c76496a8849df64ac235cb3b6e343a37d98120ec7ffb5bb0e4e336dc3f106"
        )
    ]
)
