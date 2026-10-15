// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SdkPayments",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "SdkPayments",
            targets: ["SdkPayments"])
    ],
    targets: [
        .binaryTarget(
            name: "SdkPayments",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.0.0/SdkPayments_SPM.xcframework.zip",
            checksum: "c6658c4fd78e6a2f16ea91174d7f1e46ed914e890a11a845d307a74e9baf7eb7"
        )
    ]
)
