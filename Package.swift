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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.2.3/YunoSDK_SPM.xcframework.zip",
            checksum: "4eb9022f4e795eaf649741d0c19e989aec64f9fd77a8ed8139b8859e2d255bc9"
        ),
        .binaryTarget(
            name: "OpenpayKit",
            url: "https://github.com/open-pay/openpay-swift-ios/releases/download/3.2.0/OpenpayKit.xcframework.zip",
            checksum: "a70869c996b1512e9d5167628d30c4a686dab3c743a8cd85117a194a781b3ae6"
        )
    ]
)
