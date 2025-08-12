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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.4.0/YunoSDK_SPM.xcframework.zip",
            checksum: "15cf1a7ef4f91ed54423ae35fde94c82a3c34eaf49dd9c4c8c9b0771eeace7a8"
        )
    ]
)
