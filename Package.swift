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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.11.0/YunoSDK_SPM.xcframework.zip",
            checksum: "64e7698e57764e3a04eefc7fba7a1c2fefeb7e59373a12f41c33d207e830f0c2"
        )
    ]
)
