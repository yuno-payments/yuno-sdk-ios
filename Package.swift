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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.16.0/YunoSDK_SPM.xcframework.zip",
            checksum: "f32154916039f67810087c0c2fad03193fcaa0c0cf87a51330acf23bdafc4b84"
        )
    ]
)
