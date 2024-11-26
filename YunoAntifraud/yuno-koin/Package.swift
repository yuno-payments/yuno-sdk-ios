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
            url: "https://github.com/yuno-payments/yuno-antifraud-riskified-ios/releases/download/1.0.0/YunoAntifraudRiskified.xcframework.zip",
            checksum: "09d90ab395adb1d487b19cb5cf8d5069c3cb92e6414a4ebed49650bbc8dd0406"
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