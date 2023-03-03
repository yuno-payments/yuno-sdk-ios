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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.8/YunoSDK_SPM.xcframework.zip",
            checksum: "800ef7abc398cd504b3c45b8de26a11a0fbdaf0eff2b604030cda6417a2f4c0d"
        )
    ]
)
