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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.4.1/YunoSDK_SPM.xcframework.zip",
            checksum: "641514e06bab4a8760216df81fd2bb7b9ed4e30b4f7c78d6a81993aaa3d1980a"
        )
    ]
)
