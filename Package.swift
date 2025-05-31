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
            checksum: "33d39c0f6b49ccd49b7198fe7d815c61a3e604f040e2ef23d8fea01b08bf2634"
        )
    ]
)
