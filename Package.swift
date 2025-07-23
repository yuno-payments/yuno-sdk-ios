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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.2.1/YunoSDK_SPM.xcframework.zip",
            checksum: "e649b9a95a0503fc8cd77f8e6fc37931c55fdb89fe95ebab1db886c0aa22ff77"
        )
    ]
)
