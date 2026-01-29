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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.11.1/YunoSDK_SPM.xcframework.zip",
            checksum: "0ec1f61dfbd3150ce1682fffb15fc229f1ecb7739be7f8bac967f631e636dafd"
        )
    ]
)
