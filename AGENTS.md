# AGENTS.md

Guidance for AI coding agents that integrate the Yuno iOS SDK 3.x (`SdkPayments`) into an app.

## What this package is

`SdkPayments` is the Yuno Payments iOS SDK 3.x (the Yuno SDK), distributed as prebuilt binaries through Swift Package Manager. It is **not** API-compatible with the 2.x line (`YunoSDK`, on the `master` branch of this repository): do not mix 2.x and 3.x code or docs.

This repository has no SDK source code. It contains the SPM manifest, the Objective-C wrapper targets that register the optional modules, two example apps and the Headless guides in `docs/`.

## Requirements

- iOS 14.0+
- Xcode 26.2+
- Swift 5.7+

## Install

Swift Package Manager only. Add the package in Xcode with **File > Add Package Dependencies** using `https://github.com/yuno-payments/yuno-sdk-ios.git`, or in a `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "3.1.0"))
]
```

### Pick one SDK product

| Product | Framework | When |
|---|---|---|
| `SdkPayments` | Dynamic | Default |
| `SdkPayments-Static` | Static | Moving from CocoaPods, and only one binary of the app links the SDK |

Both contain the same `SdkPayments` module, so `import SdkPayments` does not change. Never add both to a target. If the app target and one of its own dynamic frameworks import the SDK, use `SdkPayments`.

### Optional modules

| Product | Provider |
|---|---|
| `SdkPaymentsNetcetera` | Netcetera 3DS |
| `SdkAntifraudClearsale` | ClearSale |
| `SdkAntifraudKoin` | Koin |
| `SdkAntifraudRiskified` | Riskified |

Add only the modules the app uses. They work with both SDK products and register themselves at app start: no `register()` call and no `-ObjC` flag. Each provider's binary is downloaded from the provider's own URL.

### CocoaPods

CocoaPods is no longer supported: `SdkPayments` 3.1.0 is the last pod. To move, remove the pod from the `Podfile`, run `pod install`, and add this package selecting `SdkPayments-Static` plus the modules the app uses.

## Integrate

The public documentation is the single source of truth for the API and the flows. Read it instead of inferring the API from this repository:

| Topic | Page |
|---|---|
| Install and initialize | https://docs.y.uno/docs/yuno-sdk/get-started |
| Controllers (payment status, create payment, loading, views) | https://docs.y.uno/docs/yuno-sdk/controllers/overview |
| Enrollment | https://docs.y.uno/docs/yuno-sdk/features/enrollment |
| Deep links | https://docs.y.uno/docs/yuno-sdk/features/handle-deeplinks |
| Native modules (3DS and antifraud) | https://docs.y.uno/docs/yuno-sdk/features/native-modules |
| Headless (no SDK UI) | https://docs.y.uno/docs/sdks/headless-ios/checkout |

The example apps in this repository (`Example/YunoSDK`, `YunoSwiftUI/YunoSwiftUI`) are runnable references; when they and the documentation differ, follow the documentation.

## Security

- The app sends the one-time token to its own backend, which creates the payment through the Yuno API. The SDK never creates the payment.
- Never log, persist or send to analytics a card number, CVV, one-time token, vaulted token or API key.
- Enter API keys at runtime; never hardcode checkout or customer sessions.

## Pitfalls

- **Only one SDK product per target.** Never link both `SdkPayments` and `SdkPayments-Static`.
- **2.x and 3.x are different APIs.** Snippets that use `Yuno.*` or `YunoSDK` belong to 2.x and do not compile against `SdkPayments`.
- **"Upload Symbols Failed" is expected** with `SdkPayments-Static` or a module: App Store Connect warns about `SdkPayments.framework` or a module framework because Xcode embeds a placeholder binary in static frameworks. The SDK code is in the app binary and its dSYM, so crashes are still symbolicated. Ignore the warning.
- **Do not edit this package.** Depend on it by version; do not copy or modify its `Package.swift`, URLs or checksums.

## Running the examples

Both example apps use Swift Package Manager:

```bash
open Example/YunoSDK.xcodeproj           # UIKit, scheme YunoSDK-Example
open YunoSwiftUI/YunoSwiftUI.xcodeproj   # SwiftUI, target YunoSwiftUI
```

Enter a sandbox public API key in the app at runtime.

## About this repository

This is Yuno's distribution repository for the prebuilt SDK binaries, the SPM manifest and the example apps. `Package.swift` versions, URLs and checksums are updated by Yuno's release process and must not be edited by hand. External contributions are not accepted; integration questions go to [docs.y.uno](https://docs.y.uno) or Yuno support.
