// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
        .library(
            name: "YunoAntifraudClearsale",
            targets: ["YunoAntifraudClearsale"]),
        .library(
            name: "YunoAntifraudKoin",
            targets: ["YunoAntifraudKoinWrapper"]),
        .library(
            name: "Yuno3DSNetcetera",
            targets: ["Yuno3DSNetceteraWrapper"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.25.0/YunoSDK_SPM.xcframework.zip",
            checksum: "266d359f1b3b1ffe4e8a8bdb81e83d06dc6e5ffa4f51f6b82a4280fd644fc8d3"
        ),
        .binaryTarget(
            name: "YunoAntifraudClearsale",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/clearsale-1.0.0/YunoAntifraudClearsale.xcframework.zip",
            checksum: "23ee70e0f9711f4e935481bd72fc7c6dfb1442787bf7c9f009f6712d8bd2b7cb"
        ),
        .target(
            name: "YunoAntifraudKoinWrapper",
            dependencies: [
                "YunoAntifraudKoin",
                "KoinFingerprint"
            ],
            path: "YunoAntifraudKoinWrapper",
            publicHeadersPath: "include"
        ),
        .binaryTarget(
            name: "YunoAntifraudKoin",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/koin-1.0.0/YunoAntifraudKoin.xcframework.zip",
            checksum: "41339b005d00b3bbb1d9487b3aa30f7af5bc60964a6ca004331e0e6dc2308b6f"
        ),
        .binaryTarget(
            name: "KoinFingerprint",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/koin-1.0.0/KoinFingerprint.xcframework.zip",
            checksum: "33ffd08d660ee26ab0c583dcb5580f71044beff4825b481f9b5b14e327223497"
        ),
        .target(
            name: "Yuno3DSNetceteraWrapper",
            dependencies: [
                "Yuno3DSNetcetera",
                "ThreeDS_SDK"
            ],
            path: "Yuno3DSNetceteraWrapper",
            publicHeadersPath: "include"
        ),
        .binaryTarget(
            name: "Yuno3DSNetcetera",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/netcetera-3.0.0/Yuno3DSNetcetera.xcframework.zip",
            checksum: "7a7ddd0517dae5935958516e02e600f02efc8353b4b6cfa29f9295fe3a3376dd"
        ),
        .binaryTarget(
            name: "ThreeDS_SDK",
            url: "https://nexus.extranet.netcetera.biz/nexus/repository/public-repository-maven/com/netcetera/nca-341-2/3ds-sdk/ios/release/2.6.01/ThreeDS_SDK.zip",
            checksum: "90284f80dbad0258687d39a724d967f53d47db99cf4bfc3faaeee1fbe9671e2a"
        )
    ]
)
