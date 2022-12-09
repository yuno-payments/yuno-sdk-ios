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
        .target(
            name: "Resources",
            resources: [
                .copy("Assets")
            ]
        ),
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.1.0/YunoSDK.xcframework.zip",
            checksum: "93018547d8b784d57d7415f8811ebd9ec1ac96ea5e9cd56be49b0a606fa52cf6"
        )
    ]
)
