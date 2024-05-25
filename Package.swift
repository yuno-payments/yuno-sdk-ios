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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.10.1/YunoSDK_SPM.xcframework.zip",
            checksum: "ffd952b3897375d983082d33b97d040db3fc32580a1ba8d5fb093f4f254e201c"
        )
    ]
)
