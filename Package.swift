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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.21.1/YunoSDK_SPM.xcframework.zip",
            checksum: "565cf69ab66d1901be5dc4abc154135eb8bbfd3b96f3d8798d43177b43005e88"
        )
    ]
)
