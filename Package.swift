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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.15/YunoSDK_SPM.xcframework.zip",
            checksum: "4441bb503600d4082858a7cd3645019980836344b379832799ae8c089347139a"
        ),
        .binaryTarget(
            name: "OpenpayKit",
            url: "https://github.com/open-pay/openpay-swift-ios/releases/download/3.2.0/OpenpayKit.xcframework.zip",
            checksum: "4441bb503600d4082858a7cd3645019980836344b379832799ae8c089347139a"
        )
    ]
)
