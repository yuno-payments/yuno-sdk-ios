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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.5.0/YunoSDK_SPM.xcframework.zip",
            checksum: "a0d26eb5d7e0354ed1383970a4e13db5cdfec3900abcc0a93a4d47198a2cb5e7"
        )
    ]
)
