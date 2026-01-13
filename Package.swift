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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.10.0/YunoSDK_SPM.xcframework.zip",
            checksum: "d84d1913e1f93dba5714f23e836a0bb3c72a054abc743e67a05c948031a51d44"
        )
    ]
)
