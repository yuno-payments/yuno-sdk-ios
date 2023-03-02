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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.8/YunoSDK_SPM.xcframework.zip",
            checksum: "e367bdc61d76c0f5540c7f7a443edf82744d3ae0c44be5e47060ea74ec6c9d3f"
        )
    ]
)
