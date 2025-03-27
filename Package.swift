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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.23.2/YunoSDK_SPM.xcframework.zip",
            checksum: "6d5bb82abb60d2dc1182f53624ce483631798bf9a2853311b57e1ede429d42e1"
        )
    ]
)
