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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.13/YunoSDK_SPM.xcframework.zip",
            checksum: "e3356631d06613d4bcea427d1b9bbe53961ae4e8ef976168d62ecef5da7079cb"
        )
    ]
)
