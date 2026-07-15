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
            // TODO: regenerate after uploading the renamed artifact (swift package compute-checksum)
            checksum: "8e1e8dd56dad32e3dec8e58e8e1c4326fd70b6e204e4c2e545767e1b65a9495b"
        )
    ]
)
