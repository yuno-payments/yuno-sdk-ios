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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.8.1/YunoSDK_SPM.xcframework.zip",
            checksum: "e75ee1ca5be0ae848e6b7ed5b498b689dfb0001df0fbd5199af7934bad579cbf"
        )
    ]
)
