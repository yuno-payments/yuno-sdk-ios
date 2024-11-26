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
    dependencies: [
        .package(name: "YunoKoin", url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "1.20.0-beta))
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.20.0-beta/YunoSDK_SPM.xcframework.zip",
            checksum: "2b4c494b988760c76bff08a067eb18d191098eeb23165a3b3c329d12b2c06ec1"
        )
    ]
)
