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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.11.0/YunoSDK_SPM.xcframework.zip",
            checksum: "7e6edd6d39b7bed84b30ab841260e174f220c1e1b4c86b9311cd67cd01ccf6b5"
        )
    ]
)
