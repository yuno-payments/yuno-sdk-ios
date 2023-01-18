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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.5/YunoSDK_SPM.xcframework.zip",
            checksum: "071b6d536dad3f97eb8dd94d4160edfb01b33f198ec30dc18f3dd96de73f1235"
        )
    ]
)
