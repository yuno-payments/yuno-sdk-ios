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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.24.1/YunoSDK_SPM.xcframework.zip",
            checksum: "f25d36ce2f44f32a3785393da36650024be9e9e90e1f09069d5b9a24ad059915"
        )
    ]
)
