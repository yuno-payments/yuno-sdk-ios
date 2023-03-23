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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.13/YunoSDK_SPM.xcframework.zip",
            checksum: "f2f704b5ec1a726a5e799129d5931ac5decda4f779468b8e1aa5488c6fefb316"
        )
    ]
)
