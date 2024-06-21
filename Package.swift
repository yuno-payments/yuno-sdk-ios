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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.12.1/YunoSDK_SPM.xcframework.zip",
            checksum: "3fb4ba8a8e40a1a9cf9c27c3c29dee484bb08a31233555d743a00c60dbd67e79"
        )
    ]
)
