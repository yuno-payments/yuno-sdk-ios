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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.2.2/YunoSDK_SPM.xcframework.zip",
            checksum: "195109b60157a14628d64a37b1b3b87629f0c06b7d94ced0ef4d15196afbe9ca"
        )
    ]
)
