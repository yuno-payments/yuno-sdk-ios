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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.9.6/YunoSDK_SPM.xcframework.zip",
            checksum: "427ac92a2ab1c2ee18023c2a91dfb071dc47968c9ad683f6dee9d7a9bf0f2670"
        )
    ]
)
