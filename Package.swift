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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.13.1/YunoSDK_SPM.xcframework.zip",
            checksum: "8b9e47dd68a72a1cd7375f578404339a600df3923b2934310fdc98f3cdcd1661"
        )
    ]
)
