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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.21.2/YunoSDK_SPM.xcframework.zip",
            checksum: "e45ec3ed31ca29a80e3fce7c9b2d3b3ac65236f234fc87870a282a78e4576b26"
        )
    ]
)
