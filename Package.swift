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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.10/YunoSDK_SPM.xcframework.zip",
            checksum: "263397f98d58b09765e077e45f9da3403df89cd7a9e6c6e0e810f96704545cd1"
        )
    ]
)
