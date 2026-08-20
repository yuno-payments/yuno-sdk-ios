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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.22.0/YunoSDK_SPM.xcframework.zip",
            checksum: "9ee9b6221ee1a63b49d010b288324d703bd969c2220187d051e46d28a47f09bc"
        )
    ]
)
