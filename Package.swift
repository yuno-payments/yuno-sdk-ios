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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.12.3/YunoSDK_SPM.xcframework.zip",
            checksum: "90c9032396f2ebfed2795e4e924de2186b696bb6aab47700fb59ba8b3d4805bb"
        )
    ]
)
