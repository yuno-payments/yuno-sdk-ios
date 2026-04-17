# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

YunoSDK is the official Yuno Payments iOS SDK, distributed as a pre-built binary (XCFramework). It provides a fast checkout experience that integrates merchants into the payments and fraud ecosystem, supporting checkout flows, payment routing, reconciliations, and alternative payment methods. The SDK is available via CocoaPods and Swift Package Manager, and supports three integration modes: Full (complete UI), Lite (merchant-controlled UI with SDK payment logic), and Headless (full API-level control for payments and enrollment).

This repository does not contain SDK source code. It hosts the distribution manifests (`Package.swift`, `YunoSDK.podspec`), example apps (UIKit and SwiftUI), and documentation. The actual SDK binary is downloaded from GitHub Releases as an XCFramework.

## Essential Commands

### Running the Example App (UIKit - CocoaPods)
```bash
cd Example
pod install
open YunoSDK.xcworkspace
# Build and run the YunoSDK_Example scheme in Xcode (iOS 13.0+)
```

### Running the Example App (SwiftUI)
```bash
open YunoSwiftUI/YunoSwiftUI.xcodeproj
# Build and run in Xcode
```

### Validating the Podspec
```bash
pod spec lint YunoSDK.podspec
```

### Testing via SPM Integration
Add the package in Xcode via `File > Add Packages` using:
```
https://github.com/yuno-payments/yuno-sdk-ios.git
```

### Running Tests
```bash
cd Example
pod install
# Open YunoSDK.xcworkspace and run tests via Xcode (Cmd+U)
# Tests use Quick/Nimble framework
```

## Architecture Overview

### Directory Structure
```
/
├── Package.swift              # SPM manifest - defines binary target with XCFramework URL
├── YunoSDK.podspec            # CocoaPods spec - version, deployment target, vendored framework
├── CHANGELOG.md               # Release history
├── Example/                   # UIKit example app (CocoaPods-based)
│   ├── Podfile                # CocoaPods dependencies (YunoSDK, Then)
│   ├── YunoSDK.xcodeproj/    # Xcode project for the example
│   ├── YunoSDK/              # Example app source files
│   │   ├── AppDelegate.swift
│   │   ├── EnvirotmentViewController.swift  # API key entry screen
│   │   ├── HomeViewController.swift         # Flow selection (Payment/Enrollment/Lite)
│   │   ├── ViewController.swift             # Main payment/enrollment flow UI
│   │   ├── PaymentLiteViewController.swift  # Lite payment flow
│   │   └── ...
│   └── Tests/                 # Unit tests (Quick/Nimble)
├── YunoSwiftUI/               # SwiftUI example app
│   ├── YunoSwiftUI.xcodeproj/
│   └── YunoSwiftUI/
│       ├── YunoSwiftUIApp.swift
│       ├── ApiKeysView/       # API key configuration
│       ├── OptionView/        # Flow option selection
│       ├── PaymentFull/       # Full payment flow
│       └── TransactionView/   # Transaction handling
├── docs/                      # Headless SDK documentation
│   ├── HeadlessSDK(Payment).md
│   └── HeadlessSDK(Enrollment).md
└── _Pods.xcodeproj            # Symlink for CocoaPods
```

### Key Components

- **YunoSDK.xcframework**: The pre-built binary framework (downloaded from GitHub Releases, not checked into the repo). Contains the SDK for iOS 13.0+.
- **`Yuno` (main entry point)**: Static methods for SDK initialization (`Yuno.initialize(apiKey:config:)`), starting checkout (`Yuno.startCheckout(with:)`), starting payments (`Yuno.startPayment()`, `Yuno.startPaymentLite(with:paymentSelected:)`), enrollment (`Yuno.enrollPayment(with:)`), and handling deep links (`Yuno.receiveDeeplink(_:)`).
- **Delegate Protocols**:
  - `YunoPaymentDelegate` / `YunoPaymentFullDelegate`: For checkout and payment flows (provides `checkoutSession`, `countryCode`, receives OTT via `yunoCreatePayment(with:information:)`, results via `yunoPaymentResult(_:)`)
  - `YunoEnrollmentDelegate`: For payment method enrollment flows (provides `customerSession`, `countryCode`, receives results via `yunoEnrollmentResult(_:)`)
- **Headless API**: `Yuno.apiClientPayment(countryCode:checkoutSession:)` and `Yuno.apiClientEnroll(country_code:customer_session:)` for programmatic token generation and enrollment without SDK UI.
- **YunoConfig**: Configuration object for card form type (`.oneStep`/`.multiStep`), appearance customization (`Yuno.Appearance`), save card checkbox, and loader persistence.

## Key Patterns

- **Binary distribution only**: The SDK is distributed as a pre-built XCFramework. There is no compilable Swift source for the SDK itself in this repo. Changes to SDK behavior require a new binary release.
- **Version synchronization**: When updating the SDK version, three files must be updated in sync:
  1. `Package.swift` — update the download URL and checksum for the XCFramework zip
  2. `YunoSDK.podspec` — update `s.version` and the download URL implicitly uses `s.version.to_s`
  3. `Example/Podfile` — update the pod version constraint
- **Deep link handling**: The SDK requires deep link support. Apps must call `Yuno.receiveDeeplink(url)` in `application(_:open:options:)` with a custom URL scheme matching the one configured in the customer session.
- **Delegate-based callbacks**: Payment and enrollment results are delivered through delegate methods, not closures or Combine publishers. The example app wraps these in Combine where needed.
- **Localization**: The SDK supports English (EN), Spanish (ES), and Portuguese (PT) via the `language` parameter.
- **BUILD_LIBRARY_FOR_DISTRIBUTION**: The podspec enables `BUILD_LIBRARY_FOR_DISTRIBUTION` to ensure module stability across Swift compiler versions.
- **Static framework**: The CocoaPods distribution uses `static_framework = true`.

## Dependencies

### SDK (XCFramework)
- **UIKit** (system framework)
- **Combine** (system framework)

### Example App (CocoaPods)
- **YunoSDK** `~> 2.11.3` — the SDK itself
- **Then** — sugar for object initialization (used in example UI code)

### Example Tests
- **Quick** — BDD testing framework
- **Nimble** — matcher framework for Swift

### Build Requirements
- iOS deployment target: **14.0** 
- Swift version: **5.7+** 
- Xcode: **26.2+** (minimum required to build the example apps and consume the XCFramework)
- CocoaPods (`gem install cocoapods`) for the Example app
- No CI configuration is present in this repository

## Important Notes

- This repo does **not** contain the SDK source code. It is a distribution repo for the pre-built XCFramework.
- The `_Pods.xcodeproj` at the root is a symlink, not a real Xcode project.
- The default branch is `master` (not `main`).
- The Example app uses storyboards (`Base.lproj`) for its UI layout.
- The `Example/Tests/Tests.swift` contains placeholder tests from the CocoaPods template; they are not meaningful SDK tests.
- The CHANGELOG.md only covers versions up to 1.1.19; later version history (2.x) is tracked via GitHub Releases.
