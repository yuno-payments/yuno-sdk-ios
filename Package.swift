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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.6/YunoSDK_SPM.xcframework.zip",
            checksum: "14ab624bb8f43d5def29b750d505e178803e0bc1ec0ffac950c34de5ca90c7a4"
        )
    ]
)
