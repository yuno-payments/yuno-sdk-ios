# SdkPayments

[![iOS Minimum Deploy Target - 14.0](https://img.shields.io/static/v1?label=iOS+Minimum+Deploy+Target&message=14.0&color=2ea44f)](https://)
[![Xcode - 26.2+](https://img.shields.io/static/v1?label=Xcode&message=26.2%2B&color=2ea44f)](https://)
[![Swift - 5.7+](https://img.shields.io/static/v1?label=Swift&message=5.7%2B&color=2ea44f)](https://)


A fast checkout that integrates your company to the payments and fraud ecosystem.
‍
Checkout + Routing + Reconciliations + Alternative Payment Methods

## Requirements

- iOS **14.0+** 
- Xcode **26.2+**
- Swift **5.7+**

## Example

Both example apps use Swift Package Manager: open `YunoSwiftUI/YunoSwiftUI.xcodeproj` (SwiftUI) or `Example/YunoSDK.xcodeproj` (UIKit), and Xcode resolves the package.

## Installation

> **3.0.0 is a major release.** The SDK is now distributed under the module name `SdkPayments` and is **not** API-compatible with the 2.x line (`YunoSDK`). The 2.x integration lives on the `master` branch.

### [Swift Package Manager](https://swift.org/package-manager/)

Add the package in Xcode with **File > Add Package Dependencies** using `https://github.com/yuno-payments/yuno-sdk-ios.git`, or add it to the `dependencies` of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "3.1.0"))
]
```

Then add **one** of the two SDK products to your target:

| Product | Framework | Use it when |
|---|---|---|
| `SdkPayments` | Dynamic | Default. Keep it if you already integrate through SPM |
| `SdkPayments-Static` | Static | You are moving from CocoaPods, which shipped a static library |

Both products contain the same `SdkPayments` module, so `import SdkPayments` does not change. Never add both to the same target. Use `SdkPayments-Static` only when a single binary of your app links the SDK (your app target); if your app target and one of your own dynamic frameworks both import the SDK, use `SdkPayments`, or each binary gets its own copy of the SDK.

#### Optional modules

| Product | Provider |
|---|---|
| `SdkPaymentsNetcetera` | Netcetera 3DS |
| `SdkAntifraudClearsale` | ClearSale |
| `SdkAntifraudKoin` | Koin |
| `SdkAntifraudRiskified` | Riskified |

Modules work with both `SdkPayments` and `SdkPayments-Static` and register themselves when the app starts, so you don't need to call `register()`. Each provider's binary is downloaded from the provider's own release URL.

#### App Store upload warnings with `SdkPayments-Static`

When you upload an app that uses `SdkPayments-Static` or a module, App Store Connect can show "Upload Symbols Failed" for `SdkPayments.framework` or a module framework. Xcode embeds a placeholder binary in static frameworks, and that placeholder has no dSYM. The SDK code is part of your app binary and its symbols are in your app's dSYM, so crash reports are still symbolicated. You can ignore these warnings.

### CocoaPods

CocoaPods is no longer supported. `3.1.0` is the last version of `SdkPayments` available on CocoaPods, and CocoaPods trunk becomes read-only on December 2, 2026. To move to Swift Package Manager:

1. Remove the SdkPayments pod from your `Podfile` and run `pod install`.
2. Add this package with SPM and select `SdkPayments-Static` (the same static linking you had with CocoaPods), plus the modules you use.

## Usage

SdkPayments minimum required version is iOS 14.0.

### Initialize

Initialize the SDK once with your iOS public API key, for example in your application delegate:

```swift
import SdkPayments

SdkPayments.initialize(apiKey: "<Your iOS API Key>")
```

An `async` variant is available if you need to wait until the SDK is ready before creating a transaction:

```swift
await SdkPayments.initialize(apiKey: "<Your iOS API Key>")
```

### Transaction controller

Every payment and enrollment reports back through a `TransactionController`. Only `onStatus` is required; the rest have default implementations.

```swift
final class CheckoutViewController: UIViewController, SdkPayments.TransactionController {

    func onStatus(status: SdkPayments.TransactionStatus) {
        // status.status: "SUCCEEDED", "DECLINED", "USER_CANCEL", "INTERNAL_ERROR", ...
    }

    func createPayment(token: OneTimeToken) async throws {
        // Create the payment on your backend with token["token"] as? String
    }
}
```

The SDK keeps the controller weakly, so retain both the controller and the `Transaction` for the duration of the flow.

### Payment

```swift
let config = SdkPayments.TransactionConfig(
    checkoutSession: checkoutSession,
    countryCode: "CO",
    language: "es",
    controller: self,
    showStatusScreen: true,
    viewController: self
)
let transaction = SdkPayments.Transaction(config: config)
self.transaction = transaction

// Optional: render the payment methods list (conform to SdkPayments.PaymentListController)
let views = transaction.getPaymentMethodsViewsUIKit(types: [.PAYMENT_METHOD_LIST], controller: self)

// Start with the method the shopper selected
transaction.start(paymentSelected: SdkPayments.PaymentMethodSelected(paymentMethodType: "CARD"))
```

Use `getPaymentMethodsViews(types:controller:)` to get SwiftUI views instead of `UIView`s.

### Enrollment

Enrollment uses the same `Transaction`, configured with a customer session:

```swift
let config = SdkPayments.TransactionConfig(
    customerSession: customerSession,
    countryCode: "CO",
    controller: self,
    viewController: self
)
let transaction = SdkPayments.Transaction(config: config)
transaction.start(paymentSelected: SdkPayments.PaymentMethodSelected(paymentMethodType: "CARD"))
```

### Deeplinks

Forward the URLs your app receives so the SDK can resume redirect based flows:

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    SdkPayments.handleDeeplink(url)
}
```

For the full integration guide, see the [Yuno documentation](https://docs.y.uno).

## Author

Yuno Payments Inc.

## License

SdkPayments is available under the MIT license. See the LICENSE file for more info.
