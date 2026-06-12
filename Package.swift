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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.18.0/YunoSDK_SPM.xcframework.zip",
            checksum: "db2acb75af65b1dfd51a2ebd9386781accec80f98f1ad88ba81bb78f397a1317"
        )
    ]
)
