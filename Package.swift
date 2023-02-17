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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.7/YunoSDK_SPM.xcframework.zip",
            checksum: "5d4b6f518d5134054981d006a8b0455884b1a1ff4790f515fdc033a762eeaf42"
        )
    ]
)
