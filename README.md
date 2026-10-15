# SdkPayments

[![Version](https://img.shields.io/cocoapods/v/SdkPayments.svg?style=flat)](https://cocoapods.org/pods/SdkPayments)
[![License](https://img.shields.io/cocoapods/l/SdkPayments.svg?style=flat)](https://cocoapods.org/pods/SdkPayments)
[![Platform](https://img.shields.io/cocoapods/p/SdkPayments.svg?style=flat)](https://cocoapods.org/pods/SdkPayments)
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

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

> **3.0.0 is a major release.** The SDK is now distributed under the module name `SdkPayments` and is **not** API-compatible with the 2.x line (`YunoSDK`). The 2.x integration lives on the `master` branch.

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

To integrate the Yuno SDK with CocoaPods, add the line below to your Podfile:

```ruby
pod 'SdkPayments', '~> 3.0.0'
```

Then run pod install in your directory:

```shell
$ pod install
```

### [Swift Package Manager](https://swift.org/package-manager/)

Once you have your Swift package set up, add SdkPayments to the `dependencies` value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "3.0.0"))
]
```

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
