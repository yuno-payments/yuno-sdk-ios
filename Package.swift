// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"]),
        .library(
            name: "Yuno3DSNetcetera",
            targets: ["Yuno3DSNetcetera", "ThreeDS_SDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.17.0-RC.2/YunoSDK_SPM.xcframework.zip",
            checksum: "84272006ff5c70ee70c4b785344299f5a39fa81acad63fc6f7b6dd8324b6814c"
        ),
        .binaryTarget(
            name: "Yuno3DSNetcetera",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.17.0-RC.2/Yuno3DSNetcetera.xcframework.zip",
            checksum: "a366463b977f2960d0ed5e44d106604641e9a270f1fea5d11447f3e77b66947c"
        ),
        .binaryTarget(
            name: "ThreeDS_SDK",
            url: "https://nexus.extranet.netcetera.biz/nexus/repository/public-repository-maven/com/netcetera/nca-341-2/3ds-sdk/ios/release/2.6.01/ThreeDS_SDK.zip",
            checksum: "90284f80dbad0258687d39a724d967f53d47db99cf4bfc3faaeee1fbe9671e2a"
        )
    ]
)
