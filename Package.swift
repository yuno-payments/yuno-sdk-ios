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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.5.0/YunoSDK_SPM.xcframework.zip",
            checksum: "6632ca8fcfeb05a835f9b8756693e259bbda98b412e776536718a827eec4c123"
        )
    ]
)
