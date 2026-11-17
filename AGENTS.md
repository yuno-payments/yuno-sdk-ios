# AGENTS.md

Guidance for coding agents (Claude, Codex, Cursor, Gemini or other) that integrate the Yuno iOS SDK into a merchant app. `CLAUDE.md` imports this file.

## What this package is

`YunoSDK` is the official Yuno Payments iOS SDK, distributed through Swift Package Manager as prebuilt XCFrameworks. It offers these integration modes:

| Mode | What the SDK does | What your app does |
|---|---|---|
| Full | Shows the payment method list and the payment forms | Hosts the list view and starts the payment |
| Lite | Shows the payment forms | Shows its own payment method list and passes the selected method |
| Render | Returns the payment or enrollment form as a view | Places the form in its own screen and submits it |
| Enrollment | Shows the flow to save (vault) a payment method | Starts the flow with a customer session |
| Headless | No UI; returns tokens from collected data | Builds all UI and collects the data |

This repository has no SDK source code. It contains the SPM manifest, two example apps and the Headless guides.

## Requirements

- iOS **14.0+**
- Xcode **26.2+**
- Swift **5.7+**

## Install

Add the package in Xcode with **File > Add Package Dependencies** using `https://github.com/yuno-payments/yuno-sdk-ios.git`, or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "2.31.0"))
]
```

### Pick one SDK product

| Product | Framework | Use it when |
|---|---|---|
| `YunoSDK` | Dynamic | Default choice |
| `YunoSDK-Static` | Static | The app is moving from CocoaPods, which shipped a static library |

- Both products contain the same `YunoSDK` module, so the code always uses `import YunoSDK`.
- Never add both products to the same target.
- Use `YunoSDK-Static` only when a single binary of the app links the SDK (the app target). If the app target and one of the app's own dynamic frameworks both import the SDK, use `YunoSDK`; otherwise each binary gets its own copy of the SDK.

### Optional modules

| Product | Provider | Provider binary (downloaded from the provider) |
|---|---|---|
| `Yuno3DSNetcetera` | Netcetera 3DS | `ThreeDS_SDK` 2.6.01 |
| `YunoAntifraudClearsale` | ClearSale | `CSBehavior` 5.1.1 |
| `YunoAntifraudKoin` | Koin | `KoinFingerprint` 1.8.0 |
| `YunoAntifraudRiskified` | Riskified | Riskified Beacon 1.6.4 |

- Add only the modules the merchant's Yuno setup uses. They work with both `YunoSDK` and `YunoSDK-Static`.
- Modules register themselves when the app starts. Do not call `register()` and do not add `-ObjC` to the linker flags.

### CocoaPods

CocoaPods is no longer supported: `2.30.0` is the last `YunoSDK` version on CocoaPods. To migrate:

1. Remove the `YunoSDK` pod and any Yuno module pod from the `Podfile` and run `pod install`.
2. Add this package with SPM, select `YunoSDK-Static` (the same static linking CocoaPods used), plus the modules in use.
3. Existing `register()` calls for modules can stay or be removed; modules now register themselves.

## Initialize

Call `Yuno.initialize` once, before starting any flow, with the merchant's iOS public API key:

```swift
import YunoSDK

Yuno.initialize(apiKey: apiKey)
```

An optional `YunoConfig(appearance:saveCardEnabled:keepLoader:localizableBundle:)` can be passed as `Yuno.initialize(apiKey:config:)`. The card form type is not a code setting; it is configured in the Yuno Dashboard. If the app uses a `UISceneDelegate`, initialize from the scene delegate or the first screen, as the examples do.

## Flows

Every symbol below is called by the example apps (Headless: by the guides in `docs/`) and exists in the released 2.31.0 interface. Treat the examples as the source of truth for signatures; some `README.md` snippets are older.

### Full

1. Conform to `YunoPaymentFullDelegate` (it extends `YunoPaymentDelegate`).
2. Show the payment method list:
   ```swift
   Task {
       let view = await Yuno.getPaymentMethodViewAsync(delegate: self)
       // UIKit: UIView added to a container. SwiftUI: wrapped as AnyView.
   }
   ```
3. Track the selection in `yunoDidSelect(paymentMethod:)` and resize the container in `yunoUpdatePaymentMethodsViewHeight(_:)`.
4. Start the payment with `Yuno.startPayment()` or `Yuno.startPayment(showPaymentStatus: false)`.

### Lite

The app shows its own list and passes the selected method:

```swift
final class SelectedMethod: PaymentMethodSelected {
    let paymentMethodType: String
    let vaultedToken: String?
}

Yuno.startPaymentLite(with: delegate, paymentSelected: selected, showPaymentStatus: false)
```

`paymentMethodType` is the payment method type (for example `CARD`); `vaultedToken` is `nil` for a new payment method.

### Render (SwiftUI example)

```swift
let flow = await Yuno.startPaymentRenderFlow(paymentMethodSelected: selected, with: delegate)
let form = await flow.formView(paymentMethodSelected: selected, with: delegate)
// show form, then on the app's own button:
flow.submitForm()
```

```swift
let flow = Yuno.startEnrollmentRender(with: delegate)
let form = await flow.formView(with: delegate)
flow.submitForm()
```

Keep the returned flow (`YunoPaymentRenderFlowProtocol` / `YunoEnrollmentRenderFlowProtocol`) alive for as long as the form is on screen.

### Enrollment

Conform to `YunoEnrollmentDelegate` and call:

```swift
Yuno.enrollPayment(with: self)
Yuno.enrollPayment(with: self, showPaymentStatus: true)
```

### Continue a payment

After the backend creates the payment, if it requires a customer action (for example 3DS or a redirect), call `Yuno.continuePayment()` to finish it and get the final status in `yunoPaymentResult(_:)`.

### Headless

No SDK UI. Both factories `throw`:

- `try Yuno.apiClientPayment(countryCode:checkoutSession:)` returns a `YunoPaymentHeadless`: `generateToken(data:)` creates the one-time token, and after the backend creates the payment, `continueCardPayment(onResult:)` completes any remaining step (such as 3DS) and reports each status (CARD only).
- `try Yuno.apiClientEnroll(countryCode:customerSession:)` returns a `YunoEnrollHeadless`: `continueEnrollment(data:)` enrolls a card and returns its `vaultedToken`.

Guides: `docs/HeadlessSDK(Payment).md` and `docs/HeadlessSDK(Enrollment).md` in this repo, and the official docs, [Headless SDK (Payment iOS)](https://docs.y.uno/docs/sdks/headless-ios/checkout) and [Headless SDK (Enrollment iOS)](https://docs.y.uno/docs/sdks/headless-ios/enrollment).

## Delegates and results

Signatures as implemented in `Example/YunoSDK/ViewController.swift` and `YunoSwiftUI/YunoSwiftUI/TransactionView/TransactionViewModel.swift`. Members marked optional are `@objc optional` in the protocol:

```swift
// YunoPaymentDelegate
var checkoutSession: String { get }
var countryCode: String { get }
var language: String? { get }              // optional; "EN", "ES" or "PT"
var viewController: UIViewController? { get }   // optional
func yunoCreatePayment(with token: String, information: [String: Any])   // optional; implement it to receive the one-time token
func yunoPaymentResult(_ result: Yuno.Result)

// YunoPaymentFullDelegate (adds)
func yunoDidSelect(paymentMethod: PaymentMethodSelected)
func yunoDidUnenrollSuccessfully(_ success: Bool)
func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat)

// YunoEnrollmentDelegate
var customerSession: String { get }
var countryCode: String { get }
var language: String? { get }              // optional
func yunoEnrollmentResult(_ result: Yuno.Result)
```

`Yuno.Result` is a class: `result.status` is a `Yuno.Result.Status` (`.succeeded`, `.reject`, `.fail`, `.processing`, `.internalError`, `.userCancelled`), and `substatus` and `message` add detail when available. Switch on `result.status` and add an `@unknown default` branch.

## Deep links

Payment methods that leave the app (bank redirects, wallets) return through a custom URL scheme. Register the scheme in `Info.plist`, use the same scheme when the backend creates the checkout or customer session, and forward the URL:

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    guard url.scheme == "yourscheme" else { return false }
    return Yuno.receiveDeeplink(url)
}
```

In SwiftUI, call `Yuno.receiveDeeplink(_:)` from `.onOpenURL`. The UIKit example uses the scheme `yunoexample`; the SwiftUI example does not handle deep links.

## Security

- The app sends the one-time token from `yunoCreatePayment(with:information:)` to the merchant's own backend, and the backend creates the payment with Yuno's API using its private secret key. Never put the private secret key in the app.
- Never log, print, persist or send to analytics a card number, CVV, expiry date, cardholder name, one-time token, vaulted token or API key.
- Checkout sessions and customer sessions are created by the backend for each purchase or customer; never hardcode them. The example apps take the API key and sessions as runtime input.

## Pitfalls

- **Delegates are weak.** The SDK does not retain the delegate; the app must keep a strong reference (the view controller or view model) for the whole flow.
- **Main actor.** Start flows and update UI on the main actor. In the SwiftUI example the delegate methods are `nonisolated` and hop to the main actor with `Task { @MainActor in ... }` before touching UI state.
- **Session data must match.** `countryCode` must match the country of the checkout or customer session, and `language` must be `EN`, `ES` or `PT`.
- **URL scheme.** If the scheme in the session differs from the one the app registers, redirect-based payment methods never return to the app.
- **Only one SDK product per target.** Never link both `YunoSDK` and `YunoSDK-Static`.
- **"Upload Symbols Failed" is expected** with `YunoSDK-Static` or a module: App Store Connect warns about `YunoSDK.framework` or a module framework because Xcode embeds a placeholder binary in static frameworks. The SDK code is in the app binary and its dSYM, so crashes are still symbolicated. Ignore the warning.
- **Do not edit this package.** Depend on it by version; do not copy or modify its `Package.swift`, URLs or checksums.

## Reference code

| Path | Shows |
|---|---|
| `Example/YunoSDK/AppDelegate.swift` | Deep link forwarding |
| `Example/YunoSDK/EnvirotmentViewController.swift` | `Yuno.initialize` |
| `Example/YunoSDK/ViewController.swift` | Full, Lite and Enrollment with UIKit |
| `YunoSwiftUI/YunoSwiftUI/TransactionView/` | Delegates, Full, Lite and Enrollment with SwiftUI |
| `YunoSwiftUI/YunoSwiftUI/PaymentRender/` | Payment Render flow |
| `YunoSwiftUI/YunoSwiftUI/EnrollmentRender/` | Enrollment Render flow |
| `docs/HeadlessSDK(Payment).md`, `docs/HeadlessSDK(Enrollment).md` | Headless payment and enrollment (official: [payment](https://docs.y.uno/docs/sdks/headless-ios/checkout), [enrollment](https://docs.y.uno/docs/sdks/headless-ios/enrollment)) |

## Running the examples

Both apps need macOS with Xcode 26.2+, a sandbox iOS API key, and a checkout session (payments) or customer session (enrollment) created by your backend.

- UIKit: open `Example/YunoSDK.xcodeproj` and run the `YunoSDK-Example` scheme. From the command line:
  ```bash
  xcodebuild -project Example/YunoSDK.xcodeproj -scheme YunoSDK-Example \
    -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' \
    CODE_SIGNING_ALLOWED=NO build
  ```
- SwiftUI: open `YunoSwiftUI/YunoSwiftUI.xcodeproj` and run the `YunoSwiftUI` scheme (the app target requires iOS 15.0+).

Enter the API key on the first screen, then the session, country and language, and pick a flow.

## SDK 3.x

`SdkPayments` (SDK 3.x) is a different API from the 2.x `YunoSDK` described here. Do not mix 2.x symbols (`Yuno.*`, `YunoPaymentDelegate`, ...) with 3.x code.

## About this repository

This is Yuno's distribution repository for the prebuilt iOS SDK binaries, the SPM manifest and the example apps. `Package.swift`, versions, release URLs and checksums are updated by Yuno's release process and must not be edited by hand. External contributions are not accepted. For integration questions, use the official Yuno documentation (https://docs.y.uno) or Yuno support.
