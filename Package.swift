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
            checksum: "543f29a6eccd1db37c88fb454ccffcf707d65a2ce9d218930f24795ab3be0de4"
        )
    ]
)
