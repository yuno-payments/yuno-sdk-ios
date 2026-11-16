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
            targets: ["YunoAntifraudClearsaleWrapper", "YunoAntifraudClearsaleShim"]),
        .library(
            name: "YunoAntifraudKoin",
            targets: ["YunoAntifraudKoinWrapper", "YunoAntifraudKoinShim"]),
        .library(
            name: "Yuno3DSNetcetera",
            targets: ["Yuno3DSNetceteraWrapper", "Yuno3DSNetceteraShim"]),
        .library(
            name: "YunoAntifraudRiskified",
            targets: ["YunoAntifraudRiskifiedWrapper", "YunoAntifraudRiskifiedShim"])
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
            name: "YunoAntifraudClearsaleShim",
            path: "YunoAntifraudClearsaleShim"
        ),
        .binaryTarget(
            name: "YunoAntifraudClearsale",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/clearsale-1.0.2/YunoAntifraudClearsale.xcframework.zip",
            checksum: "e8e4b512dc67badc7259ec333d8ca15b63cea98b4422cbbfc53a5c44da30c909"
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
            name: "YunoAntifraudKoinShim",
            path: "YunoAntifraudKoinShim"
        ),
        .binaryTarget(
            name: "YunoAntifraudKoin",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/koin-1.0.1/YunoAntifraudKoin.xcframework.zip",
            checksum: "8bad33e8c2e7bd72600ed6c34a6104a6eefbf321fbc7afa6146b90325f45bec3"
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
            name: "Yuno3DSNetceteraShim",
            path: "Yuno3DSNetceteraShim"
        ),
        .binaryTarget(
            name: "Yuno3DSNetcetera",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/netcetera-3.0.1/Yuno3DSNetcetera.xcframework.zip",
            checksum: "05c0b34ea68a59da0cc3445c2a5b699772d2fc5ff0caec8f9930ec2fe438ce5e"
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
            name: "YunoAntifraudRiskifiedShim",
            path: "YunoAntifraudRiskifiedShim"
        ),
        .binaryTarget(
            name: "YunoAntifraudRiskified",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/riskified-2.0.0/YunoAntifraudRiskified_cocoapods.zip",
            checksum: "512e50781cdd177cb5e8c99e86259fa5546cf47e66863f1326eafd6b85530505"
        ),
        .binaryTarget(
            name: "RiskifiedBeacon",
            url: "https://github.com/Riskified/riskified_ios_sdk/archive/refs/tags/1.6.4.zip",
            checksum: "f531a5d9cf48b8c50d5d6194913db4a7028ad9f4a36324b4f87f28c8878d0b49"
        )
    ]
)
