// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YunoSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "YunoSDK",
            targets: ["YunoSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoSDK",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/2.24.1/YunoSDK_SPM.xcframework.zip",
            checksum: "14bb6dbfa88b99db3be2f8e503ea6eb582298b7ce57fc23f93175f61f7544c29"
        )
    ]
)
