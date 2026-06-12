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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.17.2/YunoSDK_SPM.xcframework.zip",
            checksum: "c64013f0a96965d0dc531c2935eaadb34629e588778b571e5165d713aa798db1"
        )
    ]
)
