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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.10.1/YunoSDK_SPM.xcframework.zip",
            checksum: "dfa15f1b46711e7b70672c92e8f248e31f7f4e1b4d13b46c798c0190cb369bbc"
        )
    ]
)
