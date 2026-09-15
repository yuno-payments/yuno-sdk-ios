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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.17.3/YunoSDK_SPM.xcframework.zip",
            checksum: "470c2e2c0107be43bcbee8e75aefb05a4c482d856dc35d801cdac71d28b8d2ae"
        )
    ]
)
