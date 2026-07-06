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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.19.0/YunoSDK_SPM.xcframework.zip",
            checksum: "ec1b87bbe05b3f2d689a0af74977a5d089fb74563d370376860c5b1efc1cc9a7"
        )
    ]
)
