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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.6.1/YunoSDK_SPM.xcframework.zip",
            checksum: "9f1f205a2d23653193b33390a7465e46b6a2d8f672dbc94ee485e273a713d052"
        ),
        .binaryTarget(
            name: "OpenpayKit",
            url: "https://github.com/open-pay/openpay-swift-ios/releases/download/3.2.0/OpenpayKit.xcframework.zip",
            checksum: "a70869c996b1512e9d5167628d30c4a686dab3c743a8cd85117a194a781b3ae6"
        )
    ]
)
