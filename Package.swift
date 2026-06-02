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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.17.1/YunoSDK_SPM.xcframework.zip",
            checksum: "736e1be63850aab697bc8d6da52b8769b39693fff42818bfb66077e68bedd163"
        )
    ]
)
