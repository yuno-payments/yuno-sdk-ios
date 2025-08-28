// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.2.2-RC/YunoSDK_SPM.xcframework.zip",
            checksum: "fdabb92a6e5ad0094e19f047dc47b0f5dc0047c66847b8a138cf69bd69217f92"
        )
    ]
)
