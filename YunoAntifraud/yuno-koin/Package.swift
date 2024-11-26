// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YunoKoin",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "YunoKoin",
            targets: ["YunoKoin", "KoinWrapper"])
    ],
    targets: [
        .binaryTarget(
            name: "YunoKoin",
            url: "https://github.com/yuno-payments/yuno-sdk-ios/releases/download/1.20.0-betaYunoKoin.xcframework.zip",
            checksum: "d496080f65dd1bd70cbc4850453cb6f02ffce0d4d172499175a3c2263fc84f8a"
        ),
        .binaryTarget(
            name: "KoinFingerprint",
            url: "https://github.com/koinlatam/ios-sdk/releases/download/1.2.0/KoinFingerprint-xcframework.zip",
            checksum: "a0285c8816ed6ea121e1e53142694a1c254e1da34c66890c908af702d6639488"),
       .target(
            name: "KoinWrapper",
            dependencies: [ 
                .target(name: "YunoKoin"),
                .target(name: "KoinFingerprint")
                ],
            path: "KoinWrapper"
        )
    ]
)