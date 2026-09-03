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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.0.0-alpha.2/SdkPayments_SPM.xcframework.zip",
            checksum: "2d41f98bbabf262ed68b1a28dbde81a5151f512beb0780832a17c36023642ddd"
        )
    ]
)
