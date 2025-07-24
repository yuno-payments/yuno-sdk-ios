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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.3.0/YunoSDK_SPM.xcframework.zip",
            checksum: "2de3c72f53090ac1e6888360cb9ebaae0107a139a5f072a3317b3993922c35b6"
        )
    ]
)
