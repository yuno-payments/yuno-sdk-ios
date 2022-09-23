// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "YunoSDK",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.0.9/YunoSDK.xcframework.zip",
            checksum: "f7609e178eac0d9849cfc3906b40a7ea5671294de625b63b4e8e6d1bd2a35c95"
        )
    ]
)