// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SdkPayments",
    defaultLocalization: "en",
    products: [
        .library(
            name: "SdkPayments",
            targets: ["SdkPayments"])
    ],
    targets: [
        .binaryTarget(
            name: "SdkPayments",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.0.0-alpha.1/SdkPayments_SPM.xcframework.zip",
            checksum: "a53617441bdfb10393a56894a22049e26dc1b7e4922344152978b314fe0f2009"
        )
    ]
)
