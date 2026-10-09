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
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.27.0/YunoSDK_SPM.xcframework.zip",
            checksum: "9138afb63f901276816cb2a43f3bc798d060295e7a103cee1746f5e6989f4810"
        ),
        .binaryTarget(
            name: "YunoAntifraudClearsale",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/clearsale-1.0.1/YunoAntifraudClearsale.xcframework.zip",
            checksum: "54ee4f77bc4b84627b59720060db9f250984449f0ec2be534b9e9f4e4332745d"
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
