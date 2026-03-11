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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.12.2/YunoSDK_SPM.xcframework.zip",
            checksum: "e8fef956f9be460d2e3ec64ed62aeeb1d397904bb9d1653d730d3ce9c91aff5d"
        )
    ]
)
