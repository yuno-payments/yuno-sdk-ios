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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.13.2/YunoSDK_SPM.xcframework.zip",
            checksum: "c8058f45cbaee310a775490cba4632cad21bd6532af20c8fa6e185fbd7044dab"
        )
    ]
)
