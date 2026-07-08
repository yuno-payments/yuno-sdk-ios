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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.20.0/YunoSDK_SPM.xcframework.zip",
            checksum: "62072083e93e7b08f481e5f2baa7b2c3f4c603debb0cda40c9c37f3a12aeb24f"
        )
    ]
)
