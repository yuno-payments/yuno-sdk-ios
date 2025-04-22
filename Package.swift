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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.24.0/YunoSDK_SPM.xcframework.zip",
            checksum: "151b3241361756e018a6f09a84da9060896a1798bcced6ea35701e2f05aa7dc8"
        )
    ]
)
