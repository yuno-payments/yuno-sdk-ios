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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.22.1/YunoSDK_SPM.xcframework.zip",
            checksum: "90d5be0fa3287bc34f87091432fc3e69f75df2e1636f25fef27efadd0b1da9dd"
        )
    ]
)
