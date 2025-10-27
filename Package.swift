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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.7.1/YunoSDK_SPM.xcframework.zip",
            checksum: "bc0e3940a542e179130b731b6f73ae65581597442dbf4596dae997e0849e2163"
        )
    ]
)
