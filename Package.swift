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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.17.0/YunoSDK_SPM.xcframework.zip",
            checksum: "2f0fea24f20ab1038072a79b4a2ab6793cd1f8005ac7545a281e7679f796f7ba"
        )
    ]
)
