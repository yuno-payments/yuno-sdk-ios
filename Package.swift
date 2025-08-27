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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.5.0-beta.1/YunoSDK_SPM.xcframework.zip",
            checksum: "71c480882a356c9c3ca4e5bcebea71ec4a5b5dee4a3d13909f0cecbc5a4e61a6"
        )
    ]
)
