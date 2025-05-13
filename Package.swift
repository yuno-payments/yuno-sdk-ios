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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.24.2/YunoSDK_SPM.xcframework.zip",
            checksum: "1f5cec38b4a10b200ab8e7aa74c16ffb0ebd6cf6a819217dc648e43a97767e05"
        )
    ]
)
