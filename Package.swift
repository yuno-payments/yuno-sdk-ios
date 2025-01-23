// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
        .library(
            name: "YunoKoin",
            targets: ["YunoKoin", "YunoWrapper"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.21.1/YunoSDK_SPM.xcframework.zip",
            checksum: "565cf69ab66d1901be5dc4abc154135eb8bbfd3b96f3d8798d43177b43005e88"
        ),
        .binaryTarget(
            name: "YunoKoin",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.21.1/YunoKoin.xcframework.zip",
            checksum: "d496080f65dd1bd70cbc4850453cb6f02ffce0d4d172499175a3c2263fc84f8a"
        ),
        .binaryTarget(
            name: "KoinFingerprint",
            url: "https://github.com/koinlatam/ios-sdk/releases/download/1.2.0/KoinFingerprint-xcframework.zip",
            checksum: "a0285c8816ed6ea121e1e53142694a1c254e1da34c66890c908af702d6639488"),
       .target(
            name: "YunoWrapper",
            dependencies: [
                .target(name: "YunoKoin"),
                .target(name: "KoinFingerprint")
                ],
            path: "YunoWrapper"
        )
    ]
)
