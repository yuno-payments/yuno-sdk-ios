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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.3/YunoSDK_SPM.xcframework.zip",
            checksum: "b381bc00edf5088ed787fbb85a2ef3218177d3b1f3d877a03ba822f2cdf4231a"
        )
    ]
)
