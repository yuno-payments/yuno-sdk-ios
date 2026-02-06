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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.11.2/YunoSDK_SPM.xcframework.zip",
            checksum: "69e1261b486a44435049aa7696e423c86f519e647fb9b015ea866056deed39d9"
        )
    ]
)
