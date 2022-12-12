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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.1/YunoSDK_SPM.xcframework.zip",
            checksum: "4706a47bad3f8f048f885ef632669c1863eeb9fa66572d19f76106926cac27ce"
        )
    ]
)
