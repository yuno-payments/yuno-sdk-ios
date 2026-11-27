// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SdkPayments",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "SdkPayments",
            targets: ["SdkPayments"]),
        .library(
            name: "SdkPayments-Static",
            targets: ["SdkPayments-Static"]),
        .library(
            name: "SdkAntifraudClearsale",
            targets: ["SdkAntifraudClearsaleWrapper", "SdkAntifraudClearsaleTarget"]),
        .library(
            name: "SdkAntifraudKoin",
            targets: ["SdkAntifraudKoinWrapper", "SdkAntifraudKoinTarget"]),
        .library(
            name: "SdkPaymentsNetcetera",
            targets: ["SdkPaymentsNetceteraWrapper", "SdkPaymentsNetceteraTarget"]),
        .library(
            name: "SdkAntifraudRiskified",
            targets: ["SdkAntifraudRiskifiedWrapper", "SdkAntifraudRiskifiedTarget"])
    ],
    targets: [
        .binaryTarget(
            name: "SdkPayments",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.3.0/SdkPayments_SPM.xcframework.zip",
            checksum: "a47b3422808a885d6af93e3a7520b5ac1fceef406f85395dcc39d9cc24136d09"
        ),
        .binaryTarget(
            name: "SdkPayments-Static",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/3.3.0/SdkPayments-Static.xcframework.zip",
            checksum: "191f4cef92dd03288240aea73ecd946bac0d3e4a4451443cb9dcb63782793ce7"
        ),
        .target(
            name: "SdkAntifraudClearsaleWrapper",
            dependencies: [
                "SdkAntifraudClearsale",
                "CSBehavior"
            ],
            path: "SdkAntifraudClearsaleWrapper",
            publicHeadersPath: "include"
        ),
        .target(
            name: "SdkAntifraudClearsaleTarget",
            path: "SdkAntifraudClearsaleTarget"
        ),
        .binaryTarget(
            name: "SdkAntifraudClearsale",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/sdkantifraudclearsale-1.0.0/SdkAntifraudClearsale.xcframework.zip",
            checksum: "fce14f9b759b90a8e1e6412f9d7f2242522a81895b1745a7327aa997a29bcdef"
        ),
        .binaryTarget(
            name: "CSBehavior",
            url: "https://device.clearsale.com.br/ios/CSBehavior.xcframework-5.1.1.zip",
            checksum: "3594a6cf7c4fb9a1db162a94e8cea814f59370c736da9b8bf48715a63866f986"
        ),
        .target(
            name: "SdkAntifraudKoinWrapper",
            dependencies: [
                "SdkAntifraudKoin",
                "KoinFingerprint"
            ],
            path: "SdkAntifraudKoinWrapper",
            publicHeadersPath: "include"
        ),
        .target(
            name: "SdkAntifraudKoinTarget",
            path: "SdkAntifraudKoinTarget"
        ),
        .binaryTarget(
            name: "SdkAntifraudKoin",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/sdkantifraudkoin-1.0.0/SdkAntifraudKoin.xcframework.zip",
            checksum: "efbaf72ae0ef7b02a663e32f6467f9484e009b4bd3e8ed37f40d8034c08204be"
        ),
        .binaryTarget(
            name: "KoinFingerprint",
            url: "https://github.com/koinlatam/ios-sdk/archive/refs/tags/1.8.0.zip",
            checksum: "4f0c23cef9a20628509791628e9f69beb9c197911f945c91bc027eaf61d3f23b"
        ),
        .target(
            name: "SdkPaymentsNetceteraWrapper",
            dependencies: [
                "SdkPaymentsNetcetera",
                "ThreeDS_SDK"
            ],
            path: "SdkPaymentsNetceteraWrapper",
            publicHeadersPath: "include"
        ),
        .target(
            name: "SdkPaymentsNetceteraTarget",
            path: "SdkPaymentsNetceteraTarget"
        ),
        .binaryTarget(
            name: "SdkPaymentsNetcetera",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/sdkpaymentsnetcetera-1.0.0/SdkPaymentsNetcetera.xcframework.zip",
            checksum: "1b7c72464d9512d5e2c9c4b106208c1b4d36a5294dfd35baf18205ee10ecfb2f"
        ),
        .binaryTarget(
            name: "ThreeDS_SDK",
            url: "https://nexus.extranet.netcetera.biz/nexus/repository/public-repository-maven/com/netcetera/nca-341-2/3ds-sdk/ios/release/2.6.01/ThreeDS_SDK.zip",
            checksum: "90284f80dbad0258687d39a724d967f53d47db99cf4bfc3faaeee1fbe9671e2a"
        ),
        .target(
            name: "SdkAntifraudRiskifiedWrapper",
            dependencies: [
                "SdkAntifraudRiskified",
                "RiskifiedBeacon"
            ],
            path: "SdkAntifraudRiskifiedWrapper",
            publicHeadersPath: "include"
        ),
        .target(
            name: "SdkAntifraudRiskifiedTarget",
            path: "SdkAntifraudRiskifiedTarget"
        ),
        .binaryTarget(
            name: "SdkAntifraudRiskified",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/sdkantifraudriskified-1.0.0/SdkAntifraudRiskified.xcframework.zip",
            checksum: "b6160354cb05a57e1a4abe5f35fb72ef1528572be7d8237ddb6bc31b93678c0c"
        ),
        .binaryTarget(
            name: "RiskifiedBeacon",
            url: "https://github.com/Riskified/riskified_ios_sdk/archive/refs/tags/1.6.4.zip",
            checksum: "f531a5d9cf48b8c50d5d6194913db4a7028ad9f4a36324b4f87f28c8878d0b49"
        )
    ]
)
