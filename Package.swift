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
            checksum: "0bb07d7f02d6668f36b2dab5e7eb01e8b87551d3914d0d379dfd940c1963056a"
        )
    ]
)
