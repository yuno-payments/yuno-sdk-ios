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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.23.1/YunoSDK_SPM.xcframework.zip",
            checksum: "7c19f2679cc64058b4829a98f349f69b620557e3151a609e5714350b3d8fd792"
        )
    ]
)
