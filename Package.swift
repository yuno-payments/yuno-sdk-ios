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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.5/YunoSDK_SPM.xcframework.zip",
            checksum: "076a49b8e6cbe3861d3c85eedf7e6b199e84cba553808dd620200e0989ec45a3"
        )
    ]
)
