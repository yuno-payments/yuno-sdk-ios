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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.1.0/YunoSDK_SPM.xcframework.zip",
            checksum: "f73296e276ff534f14176a6ba60ec1ed04cb0ff91c66889e0ad58b46fd024de5"
        )
    ]
)
