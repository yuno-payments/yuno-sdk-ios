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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.10.1/YunoSDK_SPM.xcframework.zip",
            checksum: "fb4c402644e71ca065117a4f4cec18ef4eee7125c6832a2928fa1c0557bdb802"
        )
    ]
)
