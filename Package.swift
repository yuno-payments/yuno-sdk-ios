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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.14.0/YunoSDK_SPM.xcframework.zip",
            checksum: "d6bd484854b6ed1ba4d36a7abc89462b2a6eadfaf821bb359b69d2b7652163d3"
        )
    ]
)
