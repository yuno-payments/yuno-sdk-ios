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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.13.2/YunoSDK_SPM.xcframework.zip",
            checksum: "e5e6fde3854c088e5f498343a6b281301000383c5d24cfe0a664dbdbdf1732d9"
        )
    ]
)
