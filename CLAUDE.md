# CLAUDE.md

Guidance for AI coding agents that integrate the Yuno iOS SDK 3.x (`SdkPayments`) into an app.

## What this package is

`SdkPayments` is the Yuno Payments iOS SDK 3.x, distributed as prebuilt binaries through Swift Package Manager. It is **not** API-compatible with the 2.x line (`YunoSDK`, on the `master` branch): do not mix 2.x and 3.x code or docs.

This repository has no SDK source code. It contains the SPM manifest, the Objective-C wrapper targets that register the optional modules, two example apps and the Headless guides in `docs/`.

## Requirements

- iOS 14.0+
- Xcode 26.2+
- Swift 5.7+

## Install

Swift Package Manager only. CocoaPods ended at `SdkPayments` 3.1.0.

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "3.1.0"))
]
```

Add **one** core product to the app target:

| Product | Framework | When |
|---|---|---|
| `SdkPayments` | Dynamic | Default |
| `SdkPayments-Static` | Static | Moving from CocoaPods, and only one binary of the app links the SDK |

Never add both. If the app target and one of its own dynamic frameworks import the SDK, use `SdkPayments`.

Optional modules (add only the ones the app uses): `SdkPaymentsNetcetera` (Netcetera 3DS), `SdkAntifraudClearsale`, `SdkAntifraudKoin`, `SdkAntifraudRiskified`. They work with both core products and register themselves at app start: no `register()` call and no `-ObjC` flag. Each provider's binary is downloaded from the provider's own URL.

App Store Connect may show "Upload Symbols Failed" for `SdkPayments.framework` or a module framework when the static products are used. It is expected: the SDK code is in the app binary and its symbols are in the app's dSYM.

## Usage

`README.md` (Usage) shows initialization, the transaction controller, payment, enrollment and deep links. Treat the example apps (`Example/YunoSDK`, `YunoSwiftUI/YunoSwiftUI`) as the reference for exact signatures.

- The app sends the one-time token to its own backend, which creates the payment through the Yuno API; the SDK never creates the payment.
- Never log, persist or send to analytics a card number, CVV, one-time token, vaulted token or API key. Enter keys at runtime; never hardcode checkout or customer sessions.

## About this repository

This is Yuno's distribution repository for the prebuilt SDK binaries, the SPM manifest and the example apps. `Package.swift` versions, URLs and checksums are updated by Yuno's release process and must not be edited by hand. External contributions are not accepted; integration questions go to [docs.y.uno](https://docs.y.uno) or Yuno support.
