// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.24.0/YunoSDK_SPM.xcframework.zip",
            checksum: "b7a63aeabeed74b21e94363a006cf51e72e3703cbca987d3cd2ddaba18f4f738"
        )
    ]
)
