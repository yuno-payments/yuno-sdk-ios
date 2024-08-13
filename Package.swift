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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.0.0-clearsale/YunoSDK_SPM.xcframework.zip",
            checksum: "53f1fc1854f75a0b2fba4862b8941e470c81813daf4bfbe4c16359f75606b3e5"
        )
    ]
)
