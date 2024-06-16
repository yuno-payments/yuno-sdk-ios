// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.12.0/YunoSDK_SPM.xcframework.zip",
            checksum: "3ca326ff0e86a62046f222a636775fcaff3e1a77de7c76574b98206a0ac0136d"
        )
    ]
)
