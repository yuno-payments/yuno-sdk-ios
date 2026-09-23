// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
        .library(
            name: "YunoAntifraudClearsale",
            targets: ["YunoAntifraudClearsale"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.25.0/YunoSDK_SPM.xcframework.zip",
            checksum: "266d359f1b3b1ffe4e8a8bdb81e83d06dc6e5ffa4f51f6b82a4280fd644fc8d3"
        ),
        .binaryTarget(
            name: "YunoAntifraudClearsale",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/clearsale-1.0.0/YunoAntifraudClearsale.xcframework.zip",
            checksum: "23ee70e0f9711f4e935481bd72fc7c6dfb1442787bf7c9f009f6712d8bd2b7cb"
        )
    ]
)
