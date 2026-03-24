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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.12.3/YunoSDK_SPM.xcframework.zip",
            checksum: "888134e1b066ea8902376aca71efad6d7150a02aa213dbc21f5a66d4c9b2df61"
        )
    ]
)
