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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.12.1/YunoSDK_SPM.xcframework.zip",
            checksum: "5ab7adada3970a2c2e6c3df22a8209e558f7fcee5c1190b0509b1b65d8e6debf"
        )
    ]
)
