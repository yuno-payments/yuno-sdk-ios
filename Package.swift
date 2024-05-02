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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.6.3/YunoSDK_SPM.xcframework.zip",
            checksum: "93dd1538d323f3d3512f951d87da3870b883b6fe5b39d7a7c5206d2c2eb49881"
        )
    ]
)
