# AGENTS.md

Guidance for any engineer or coding agent (Claude, Codex, Cursor, Gemini or other) working in this repository. `CLAUDE.md` imports this file; keep the content here.

## Overview

YunoSDK is the official Yuno Payments iOS SDK, distributed as pre-built binaries (XCFrameworks). It provides a fast checkout experience that integrates merchants into the payments and fraud ecosystem, supporting checkout flows, payment routing, reconciliations, and alternative payment methods. The SDK is available via CocoaPods and Swift Package Manager, and supports three integration modes: Full (complete UI), Lite (merchant-controlled UI with SDK payment logic), and Headless (full API-level control for payments and enrollment).

This repository does not contain SDK source code. It is the public distribution repository: it hosts the distribution manifests (`Package.swift`, `YunoSDK.podspec` and one podspec per optional module), example apps (UIKit and SwiftUI), and documentation. The SDK binaries are downloaded from GitHub Releases of this repository. The SDK source lives in the private monorepo `yuno-payments/yuno-ios`; its CI (Bitrise, `yuno-build` workflow) builds the XCFrameworks, publishes the GitHub release and the CocoaPods trunk push, and opens the "Change version number" pull requests here.

## SDK lines: Universal and Legacy

| Line | Product (module, pod, SPM product) | Version | Branch in this repo | Source branch in `yuno-ios` |
|------|------------------------------------|---------|---------------------|-----------------------------|
| **Legacy** | `YunoSDK` + optional modules (`YunoAntifraudClearsale`, `YunoAntifraudKoin`, `YunoAntifraudRiskified`, `Yuno3DSNetcetera`, `YunoRevolutPay`) | 2.x (currently 2.29.0) | `master` (default branch) | `develop` → `release-v<x.y.z>` → `master` |
| **Universal** | `SdkPayments` (single `SdkPayments.Transaction` entry point, results via `SdkPayments.TransactionController`) | 3.x (3.0.0 released 2026-10-15) | `release-3.0.0`; prereleases on `universal/3.0.0-alpha.*` | `universal-SDK` |

- 3.x is a major release and is **not API-compatible** with 2.x. Do not copy 2.x API (`Yuno.*`, `YunoPaymentDelegate`, ...) into Universal docs or examples, or the reverse.
- Everything else in this file describes `master` (Legacy) unless a section says otherwise.

### Universal ↔ Legacy parity rule

Every change to documentation, examples, manifests or modules on one line must be applied to the other line in the same cycle, or explicitly recorded as not applicable, with the reason, in the pull request description. Exceptions that never port: version numbers, checksums and release asset URLs (each line has its own), and API that only exists on one line. When in doubt, ask the iOS code owners (`.github/CODEOWNERS`) before skipping a port.

## Essential Commands

Tooling: macOS with Xcode 26.2+, CocoaPods (`gem install cocoapods`) and the Swift toolchain that ships with Xcode. None of these commands run on Linux.

### Running the Example App (UIKit - CocoaPods)
```bash
cd Example
pod install                 # generates YunoSDK.xcworkspace and Pods/ (both git-ignored)
open YunoSDK.xcworkspace
# Build and run the YunoSDK-Example scheme (target YunoSDK_Example) in Xcode
```
Command-line build (no signing):
```bash
xcodebuild -workspace Example/YunoSDK.xcworkspace -scheme YunoSDK-Example \
  -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO build
```

### Running the Example App (SwiftUI - SPM)
```bash
open YunoSwiftUI/YunoSwiftUI.xcodeproj
# Xcode resolves the yuno-sdk-ios package (product YunoSDK, up to next major from 2.15.0); build and run the YunoSwiftUI scheme
```

### Validating the Podspecs
```bash
pod spec lint YunoSDK.podspec
pod spec lint Yuno3DSNetcetera.podspec YunoAntifraudKoin.podspec YunoAntifraudRiskified.podspec YunoClearsaleAntifraud.podspec YunoRevolutPay.podspec
```

### Validating the SPM Manifest
```bash
swift package dump-package > /dev/null   # manifest parses
swift package resolve                    # downloads every binary target and verifies its checksum
```
Or add the package in Xcode via `File > Add Packages` using:
```
https://github.com/yuno-payments/yuno-sdk-ios.git
```

## How to test

There are no runnable unit tests in this repository, because there is no SDK source to test. SDK unit tests live in `yuno-ios`.

- `Example/Tests/Tests.swift` is the CocoaPods template placeholder (half of its specs fail on purpose). No test target compiles it: `Example/YunoSDK.xcodeproj` has a single target, `YunoSDK_Example`, and the Podfile does not install Quick or Nimble. The `YunoSDK-Example` scheme still lists `YunoSDK_Tests` / `YunoSDK-Unit-Tests` targets that no longer exist, so `Cmd+U` / `xcodebuild test` do not run anything meaningful.
- A change is verified by the checks that match what it touches:

| You changed | Verify with |
|-------------|-------------|
| `Package.swift` (URL, checksum, product, target) | `swift package dump-package` and `swift package resolve` (checksum mismatch fails resolve), then build the SwiftUI app |
| A `*.podspec` | `pod spec lint <name>.podspec` |
| `Example/` | `pod install`, then the `xcodebuild ... build` command above, then a Full, Lite and Enrollment run against a sandbox API key |
| `YunoSwiftUI/` | Build and run the `YunoSwiftUI` scheme |
| `README.md`, `docs/`, `AGENTS.md` | Every symbol and signature you document exists in the released binary or the example apps (`grep -rn "Yuno\." Example/YunoSDK YunoSwiftUI/YunoSwiftUI`); every link and version matches `Package.swift` / `YunoSDK.podspec` |

- If you cannot run a check (for example, no macOS host), say so in the pull request and state how you verified the change instead. Never claim a check passed that you did not run.

## Architecture Overview

### Directory Structure (`master`)
```
/
├── AGENTS.md                  # This file (CLAUDE.md imports it)
├── Package.swift              # SPM manifest - 5 library products, binary targets pinned by URL + checksum
├── YunoSDK.podspec            # CocoaPods spec of the core SDK
├── Yuno3DSNetcetera.podspec   # Optional module pods, each with its own version and asset tag
├── YunoAntifraudKoin.podspec
├── YunoAntifraudRiskified.podspec
├── YunoClearsaleAntifraud.podspec
├── YunoRevolutPay.podspec     # CocoaPods only (not in Package.swift), iOS 15+
├── Yuno3DSNetceteraWrapper/   # SPM wrapper targets (dummy.m + include/) that bundle a module
├── YunoAntifraudKoinWrapper/  #   binary with its third-party binary
├── YunoAntifraudRiskifiedWrapper/
├── CHANGELOG.md               # Release history up to 1.1.19 only (2.x lives in GitHub Releases)
├── .github/CODEOWNERS         # iOS maintainers requested on every PR (no CI workflows)
├── Example/                   # UIKit example app (CocoaPods-based)
│   ├── Podfile                # CocoaPods dependencies (YunoSDK, Then)
│   ├── YunoSDK.xcodeproj/     # Xcode project, target YunoSDK_Example, scheme YunoSDK-Example
│   ├── YunoSDK/               # Example app source files
│   │   ├── AppDelegate.swift
│   │   ├── EnvirotmentViewController.swift  # API key entry screen
│   │   ├── HomeViewController.swift         # Flow selection (Payment/Enrollment/Lite)
│   │   ├── ViewController.swift             # Main payment/enrollment flow UI
│   │   ├── PaymentLiteViewController.swift  # Lite payment flow
│   │   └── ...
│   └── Tests/                 # CocoaPods template placeholder, not wired to any target
├── YunoSwiftUI/               # SwiftUI example app (SPM-based)
│   ├── YunoSwiftUI.xcodeproj/
│   └── YunoSwiftUI/
│       ├── YunoSwiftUIApp.swift
│       ├── ApiKeysView/       # API key configuration
│       ├── OptionView/        # Flow option selection
│       ├── PaymentFull/       # Full payment flow
│       ├── PaymentRender/     # Render payment flow
│       ├── EnrollmentRender/  # Render enrollment flow
│       └── TransactionView/   # Transaction handling
└── docs/                      # Headless SDK documentation
    ├── HeadlessSDK(Payment).md
    └── HeadlessSDK(Enrollment).md
```

### Key Components

- **YunoSDK.xcframework**: The pre-built binary framework (downloaded from GitHub Releases, not checked into the repo).
- **`Yuno` (main entry point)**: Static methods for SDK initialization (`Yuno.initialize(apiKey:config:)`), the Full payment method view (`Yuno.getPaymentMethodViewAsync(delegate:)`), starting payments (`Yuno.startPayment()`, `Yuno.startPaymentLite(with:paymentSelected:)`, `Yuno.continuePayment()`), render flows (`Yuno.startPaymentRenderFlow`, `Yuno.startEnrollmentRender`), enrollment (`Yuno.enrollPayment(with:)`), and handling deep links (`Yuno.receiveDeeplink(_:)`).
- **Delegate Protocols**:
  - `YunoPaymentDelegate` / `YunoPaymentFullDelegate`: For checkout and payment flows (provides `checkoutSession`, `countryCode`, receives OTT via `yunoCreatePayment(with:information:)`, results via `yunoPaymentResult(_:)`)
  - `YunoEnrollmentDelegate`: For payment method enrollment flows (provides `customerSession`, `countryCode`, receives results via `yunoEnrollmentResult(_:)`)
- **Headless API**: `Yuno.apiClientPayment(countryCode:checkoutSession:)` and `Yuno.apiClientEnroll(country_code:customer_session:)` for programmatic token generation and enrollment without SDK UI.
- **YunoConfig**: Configuration object for card form type (`.oneStep`/`.multiStep`), appearance customization (`Yuno.Appearance`), save card checkbox, and loader persistence.
- **Optional modules**: 3DS (`Yuno3DSNetcetera`, bundles Netcetera `ThreeDS_SDK`), antifraud (`YunoAntifraudClearsale`, `YunoAntifraudKoin`, `YunoAntifraudRiskified`) and Revolut Pay (`YunoRevolutPay`, CocoaPods only). Per ADR-0004 they are products of this package and reach `Package.swift` only in an SDK release.

## Key Patterns

- **Binary distribution only**: There is no compilable Swift source for the SDK itself in this repo. Changes to SDK behavior require a new binary release from `yuno-ios`.
- **Version synchronization** (core SDK): these files must be updated in sync, normally by the release PR CI opens:
  1. `Package.swift` — the `YunoSDK` binary target download URL and checksum
  2. `YunoSDK.podspec` — `s.version` (the download URL uses `s.version.to_s`)
  3. `Example/Podfile` — the pod version constraint
  4. `README.md` — the install snippets
- **Module versions**: each optional module has its own semantic version in its podspec and its own release asset tag (`<module>-<version>`, e.g. `koin-1.0.0`, `riskified-2.0.0`). Its `Package.swift` URL and checksum point at that tag, and its podspec declares the minimum `YunoSDK` it needs.
- **Deep link handling**: Apps must call `Yuno.receiveDeeplink(url)` in `application(_:open:options:)` with a custom URL scheme matching the one configured in the customer session.
- **Delegate-based callbacks**: Payment and enrollment results are delivered through delegate methods, not closures or Combine publishers. The example app wraps these in Combine where needed.
- **Localization**: The SDK supports English (EN), Spanish (ES), and Portuguese (PT) via the `language` parameter.
- **BUILD_LIBRARY_FOR_DISTRIBUTION**: The podspecs enable `BUILD_LIBRARY_FOR_DISTRIBUTION` to ensure module stability across Swift compiler versions.
- **Static framework**: The CocoaPods distribution uses `static_framework = true`.

## Dependencies

### SDK (XCFramework)
- **UIKit** and **Combine** (system frameworks)

### Optional modules (third-party binaries, pinned)
- `Yuno3DSNetcetera`: Netcetera `ThreeDS_SDK` 2.6.01 (SPM, from Netcetera's Nexus)
- `YunoAntifraudKoin`: `KoinFingerprint` (shipped on the `koin-1.0.0` asset tag)
- `YunoAntifraudRiskified`: Riskified Beacon 1.6.4 (SPM) / `RiskifiedBeaconXCFramework ~> 1.6.4` (pod)
- `YunoRevolutPay`: `RevolutPayments/RevolutPay ~> 3.16.0`, `lottie-ios >= 4.4.1, < 4.6`

Any new third-party dependency must be pinned (exact version or checksum) and listed here.

### Example App (CocoaPods)
- **YunoSDK** `~> 2.29.0` — the SDK itself
- **Then** — sugar for object initialization (used in example UI code)

### Build Requirements
- iOS deployment target: **14.0** for SPM (`Package.swift`) and the module pods; `YunoSDK.podspec` and the UIKit example still declare 13.0; `YunoRevolutPay` needs 15.0
- Swift version: **5.7+** (`YunoSDK.podspec` still declares `swift_version` 5.4)
- Xcode: **26.2+** (minimum required to build the example apps and consume the XCFramework)
- CocoaPods (`gem install cocoapods`) for the Example app
- No CI workflows run in this repository; releases are pushed here by the `yuno-ios` Bitrise pipeline

## Code rules

This repo only holds example and manifest code, but it is what merchants copy. Hold it to the same rules as the SDK.

### Architecture (iOS)
- Keep example screens thin: a view or view controller renders and forwards events; SDK delegate conformance and flow state live in one place per flow (a view model in SwiftUI, the flow's view controller in UIKit). Do not add a new layer for a single use.
- Integrate only through the SDK's public API, exactly as a merchant would. Never rely on undocumented SDK symbols in examples or docs.
- Delegates are weak on the SDK side: the integrator owns and retains its delegate. Show it that way in examples.
- No new dependency in the SDK binaries (ADR 001 of `yuno-ios`); a new third-party dependency in a module or example needs a reason in the PR and a pinned version.
- Public SDK types stay Objective-C compatible (`NSObject` subclasses, `Int` enums); document them as such.

### Swift clean code
- Follow the Swift API Design Guidelines; names state intent, no abbreviation-only names.
- `private` by default, `final class` for leaf types, `struct` and `enum` where no identity is needed.
- No force unwrap (`!`) or `try!`; use `guard let` and handle the failure.
- Closures that outlive the call capture `[weak self]`; store Combine subscriptions in `Set<AnyCancellable>`.
- Async SDK calls run in `Task { await ... }`; UI updates happen on the main actor.
- Files under 500 lines, functions under 50 lines; split a type when it grows past one responsibility.
- No commented-out code and no code comments that restate the code.
- Match the surrounding file's style over personal preference.

### Security and card data
- Never log, print, persist or send to analytics a PAN, CVV, expiry date, cardholder name, one-time token, vaulted token or API key, in example code, docs or tests. Use the masked placeholders the docs already use.
- No `print` with payment data; example logging is limited to flow results (status values).
- Never commit real API keys, checkout or customer sessions; the example apps read keys entered at runtime.
- Binary targets are always pinned by checksum; never replace a checksum without the matching release asset.

## Pull request rules

- **Scope**: one concern per PR. The PR description says what changed, why, and how it was verified (see "How to test").
- **Improve what you touch**: fix small defects in the lines and files you are already changing (stale doc, wrong signature, a lint issue), and list them in the PR.
- **Refactor limit**: if a cleanup or refactor would touch more than 3 files beyond the ones the task needs, do not include it. Open a separate PR for it, backed by its own AnyForge work item.
- **Parity**: state in the PR whether the change was ported to the other line (Universal ↔ Legacy) or why it does not apply.
- **Traceability**: reference the work item or ticket (`Fixes <code>`) in the PR description, never in code.
- Write PRs, commits and docs in English. Branches use a type prefix (`docs/`, `fix/`, `feat/`, `chore/`).
- Do not edit version numbers, URLs or checksums by hand outside a release; the `yuno-ios` release pipeline owns them.
- A code owner from `.github/CODEOWNERS` approves every PR.

## Important Notes

- This repo does **not** contain the SDK source code. It is a distribution repo for the pre-built XCFrameworks.
- The default branch is `master` (not `main`), and it carries the Legacy 2.x line.
- `Example/YunoSDK.xcworkspace` and `Example/Pods/` are generated by `pod install` and are not committed.
- The Example app uses storyboards (`Base.lproj`) for its UI layout.
- `Example/Tests/Tests.swift` contains placeholder tests from the CocoaPods template; they are not meaningful SDK tests and no target builds them.
- The CHANGELOG.md only covers versions up to 1.1.19; later version history (2.x and 3.x) is tracked via GitHub Releases.
