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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.13.1/YunoSDK_SPM.xcframework.zip",
            checksum: "296fa7e13f59a77b1ab17805efed916d6be15a2cd356c7ad382ce98432854e45"
        )
    ]
)
