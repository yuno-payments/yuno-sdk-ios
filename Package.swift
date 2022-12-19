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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.5.8/YunoSDK_SPM.xcframework.zip",
            checksum: "cde8195cc501329472ec68bb11cb87a5346bc81dccd7b12f34cf23e829268ba1"
        )
    ]
)
