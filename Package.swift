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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.12/YunoSDK_SPM.xcframework.zip",
            checksum: "55938f425993d65282ed1bce3a790df7df3740a433f69887a71fa40521abc20d"
        )
    ]
)
