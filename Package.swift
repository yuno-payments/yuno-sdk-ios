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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.5.0-beta.1/YunoSDK_SPM.xcframework.zip",
            checksum: "7db559111a3d7bf830fab5c37c5a9886d8da152fee7a17e9fdc36ff61461ef21"
        )
    ]
)
