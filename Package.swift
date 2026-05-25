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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.17.0/YunoSDK_SPM.xcframework.zip",
            checksum: "e3e3fa562a76a7e93177778da372d91b1b6b0f1c4d0752f0be279fbe71c28232"
        )
    ]
)
