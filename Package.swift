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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.1.0/SdkPayments_SPM.xcframework.zip",
            checksum: "133b51d964d5fc838abae7a66ed71126a07514c189e0c26506a82f43065e9a3d"
        )
    ]
)
