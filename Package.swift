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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.19.0/YunoSDK_SPM.xcframework.zip",
            checksum: "7b5616ba9202a734c7372e59769c2bd565c72b0e01fba3de1716cc077cb239aa"
        )
    ]
)
