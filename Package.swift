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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.0.0/YunoSDK_SPM.xcframework.zip",
            checksum: "db424ef4a5b9bbf2f200f52bf3c165d04868e4e5c73640d5ac5b7701d8e8c503"
        )
    ]
)
