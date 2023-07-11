// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK", "OpenpayKit"]),
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/40.40.40/YunoSDK_SPM.xcframework.zip",
            checksum: "f681b71f04be1680e00ccd5ac87d988fd9d38e0bd7b9f176aee8434a73baf365"
        ),
        .binaryTarget(
            name: "OpenpayKit",
            url: "https://github.com/open-pay/openpay-swift-ios/releases/download/3.2.0/OpenpayKit.xcframework.zip",
            checksum: "a70869c996b1512e9d5167628d30c4a686dab3c743a8cd85117a194a781b3ae6"
        )
    ]
)
