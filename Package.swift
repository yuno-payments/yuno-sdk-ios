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
            name: "YunoSDK-Static",
            targets: ["YunoSDK-Static"]),
        .library(
            name: "YunoAntifraudClearsale",
            targets: ["YunoAntifraudClearsaleWrapper", "YunoAntifraudClearsaleTarget"]),
        .library(
            name: "YunoAntifraudKoin",
            targets: ["YunoAntifraudKoinWrapper", "YunoAntifraudKoinTarget"]),
        .library(
            name: "Yuno3DSNetcetera",
            targets: ["Yuno3DSNetceteraWrapper", "Yuno3DSNetceteraTarget"]),
        .library(
            name: "YunoAntifraudRiskified",
            targets: ["YunoAntifraudRiskifiedWrapper", "YunoAntifraudRiskifiedTarget"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.30.0/YunoSDK_SPM.xcframework.zip",
            checksum: "0186393d69a893ee17abaf5cdf7587ae8e4e4f9fef0a0083e75c83e7e3b9f0ab"
        ),
        .binaryTarget(
            name: "YunoSDK-Static",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.30.0/YunoSDK-Static.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        ),
        .target(
            name: "YunoAntifraudClearsaleWrapper",
            dependencies: [
                "YunoAntifraudClearsale",
                "CSBehavior"
            ],
            path: "YunoAntifraudClearsaleWrapper",
            publicHeadersPath: "include"
        ),
        .target(
            name: "YunoAntifraudClearsaleTarget",
            path: "YunoAntifraudClearsaleTarget"
        ),
        .binaryTarget(
            name: "YunoAntifraudClearsale",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/clearsale-1.0.2/YunoAntifraudClearsale.xcframework.zip",
            checksum: "d80a12e560343823215c91242aeb9ef2ea11ee2e1d9e1bdcae0142d588381987"
        ),
        .binaryTarget(
            name: "CSBehavior",
            url: "https://device.clearsale.com.br/ios/CSBehavior.xcframework-5.1.1.zip",
            checksum: "3594a6cf7c4fb9a1db162a94e8cea814f59370c736da9b8bf48715a63866f986"
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
        .target(
            name: "YunoAntifraudKoinTarget",
            path: "YunoAntifraudKoinTarget"
        ),
        .binaryTarget(
            name: "YunoAntifraudKoin",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/koin-1.0.1/YunoAntifraudKoin.xcframework.zip",
            checksum: "d81d67d3114e4f716d1422c574ff42c49d8cd2dd3c448eb463a5536db4f1faea"
        ),
        .binaryTarget(
            name: "KoinFingerprint",
            url: "https://github.com/koinlatam/ios-sdk/archive/refs/tags/1.8.0.zip",
            checksum: "4f0c23cef9a20628509791628e9f69beb9c197911f945c91bc027eaf61d3f23b"
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
        .target(
            name: "Yuno3DSNetceteraTarget",
            path: "Yuno3DSNetceteraTarget"
        ),
        .binaryTarget(
            name: "Yuno3DSNetcetera",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/netcetera-3.0.1/Yuno3DSNetcetera.xcframework.zip",
            checksum: "f71c4cc25d9001df48a1af7868bc29cc44e8cc42da20a7a08ffe543f07da1376"
        ),
        .binaryTarget(
            name: "ThreeDS_SDK",
            url: "https://nexus.extranet.netcetera.biz/nexus/repository/public-repository-maven/com/netcetera/nca-341-2/3ds-sdk/ios/release/2.6.01/ThreeDS_SDK.zip",
            checksum: "90284f80dbad0258687d39a724d967f53d47db99cf4bfc3faaeee1fbe9671e2a"
        ),
        .target(
            name: "YunoAntifraudRiskifiedWrapper",
            dependencies: [
                "YunoAntifraudRiskified",
                "RiskifiedBeacon"
            ],
            path: "YunoAntifraudRiskifiedWrapper",
            publicHeadersPath: "include"
        ),
        .target(
            name: "YunoAntifraudRiskifiedTarget",
            path: "YunoAntifraudRiskifiedTarget"
        ),
        .binaryTarget(
            name: "YunoAntifraudRiskified",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/riskified-2.0.1/YunoAntifraudRiskified.xcframework.zip",
            checksum: "0a4a3b078e05e0cc60e8060747bbe0c2523fb8963616c135d0ace889deccd601"
        ),
        .binaryTarget(
            name: "RiskifiedBeacon",
            url: "https://github.com/Riskified/riskified_ios_sdk/archive/refs/tags/1.6.4.zip",
            checksum: "f531a5d9cf48b8c50d5d6194913db4a7028ad9f4a36324b4f87f28c8878d0b49"
        )
    ]
)
