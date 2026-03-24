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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.14.0/YunoSDK_SPM.xcframework.zip",
            checksum: "3cfc5b3dab49499d62d61762da9870f86bc48398110ea7b4589f7e555b688ab8"
        )
    ]
)
