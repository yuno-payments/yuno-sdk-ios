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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.13.1/YunoSDK_SPM.xcframework.zip",
            checksum: "17e4bc40d7cacb94f588e920def96a50baf0e3939c550fe856eb486e8017e531"
        )
    ]
)
