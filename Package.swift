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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.26/YunoSDK_SPM.xcframework.zip",
            checksum: "a5a56603e0d94bb8105db8ffccbbfbb47f3e6b4067a2a609e61a9e765e69162b"
        ),
        .binaryTarget(
            name: "OpenpayKit",
            url: "https://github.com/open-pay/openpay-swift-ios/releases/download/3.2.0/OpenpayKit.xcframework.zip",
            checksum: "a70869c996b1512e9d5167628d30c4a686dab3c743a8cd85117a194a781b3ae6"
        )
    ]
)
