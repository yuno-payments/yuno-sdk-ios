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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.23.1/YunoSDK_SPM.xcframework.zip",
            checksum: "b78e52b25286e1bb5e9bf128405f001a74e0017f62f32620fba74dd700f9481d"
        )
    ]
)
