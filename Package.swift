// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.25.0/YunoSDK_SPM.xcframework.zip",
            checksum: "266d359f1b3b1ffe4e8a8bdb81e83d06dc6e5ffa4f51f6b82a4280fd644fc8d3"
        )
    ]
)
