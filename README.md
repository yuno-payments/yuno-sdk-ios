# YunoSDK

[![Version](https://img.shields.io/cocoapods/v/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![License](https://img.shields.io/cocoapods/l/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![Platform](https://img.shields.io/cocoapods/p/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
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

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

To integrate Yuno SDK with Cocoapods, please add the line below to your Podfile and run pod install.

```ruby
pod 'YunoSDK', '~> 2.16.0'
```

Then run pod install in your directory:

```shell
$ pod install
```
### [Swift Package Manager](https://swift.org/package-manager/)

Once you have your Swift package set up, adding YunoSDK as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", .upToNextMajor(from: "1.1.17"))
]
```

## Optional 3DS provider: Netcetera

`YunoSDK3DSNetcetera` plugs Netcetera's `ThreeDS_SDK` into YunoSDK so card
payments can run the 3DS challenge flow.

**Requires YunoSDK 2.17.0 or newer.** YunoSDK is intentionally **not**
declared as a transitive dependency — you add it explicitly so the
version is the same across other Yuno side-libraries you may use.

### Swift Package Manager (auto-registration)

The SPM distribution is a **dynamic framework**: the provider registers
itself with `YunoThreeDSRegistry` at framework load time (via an ObjC
`+load` bootstrap). No setup code required — just add the products to
your target:

```swift
dependencies: [
    .package(url: "https://github.com/yuno-payments/yuno-sdk-ios.git", from: "2.17.0")
],
targets: [
    .target(name: "MyApp", dependencies: [
        .product(name: "YunoSDK",          package: "yuno-sdk-ios"),
        .product(name: "Yuno3DSNetcetera", package: "yuno-sdk-ios")
    ])
]
```

### CocoaPods (manual registration)

The CocoaPods distribution is a **static framework** (matches the static
YunoSDK pod). The `+load` bootstrap is intentionally **not** shipped in
this variant, so you must register the provider yourself once at app
startup:

```ruby
# Podfile
pod 'YunoSDK',              '~> 2.17'
pod 'YunoSDK3DSNetcetera',  '~> 2.17'
```

```swift
// AppDelegate.swift
import YunoSDK
import Yuno3DSNetcetera

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Yuno3DSNetcetera.register()
        Yuno.initialize(apiKey: "<your iOS API key>")
        return true
    }
}
```

If you forget the `Yuno3DSNetcetera.register()` call, card payments fall
back to no-3DS provider and the challenge flow won't appear.

If `YunoSDK` is missing or older than 2.17.0 in the Podfile, the build
fails with undefined symbols (`_OBJC_CLASS_$_YunoThreeDSRegistry`, etc.).

### Sandbox certificate

When initializing the SDK against the **sandbox** environment, you must
include `acq-root-certeq-prev-environment.crt` in your app's bundle
resources. Yuno provides the file at onboarding. The production
environment does not require it.

## Usage
YunoSDK minimum required version is iOS 14.0

First, you'll need to get your Yuno app ID and iOS API key. Then initialize Yuno by importing Yuno and adding the following to your application delegate:

> Note: If your app is using a UISceneDelegate you will need to put your Yuno initialisation code into your SceneDelegate

```swift
import YunoSDK

Yuno.initialize(
    apiKey: "<Your iOS API Key>",
    config: YunoConfig() // This is optional, by default it configures .oneStep card form and disables save card checkbox.
)
```

## YunoConfig:

```swift

final class YunoConfig {
    let cardFormType: CardFormType, // This is optional, .oneStep by default, this is to choose Payment and Enrollment Card flow.
    let appearance: Yuno.Appearance, // This is optional, by default uses Yuno styles.
    let saveCardEnabled: Bool, // This is to choose if show save card checkbox on cards flows. It is false by default
    let keepLoader: Bool,
}
```


##### Appearance
With Yuno.Appearance you can customize the SDK styles:

```swift
let appearance = Yuno.Appearance(fontFamily: "Climate Crisis",
                                 accentColor: .orange, 
                                 buttonBackgroundColor: .yellow, 
                                 buttonTitleColor: .black, 
                                 buttonBorderColor: .black,
                                 secondaryButtonBackgroundColor: .yellow,
                                 secondaryButtonTitleColor: .black,
                                 secondaryButtonBorderColor: .black,
                                 disableButtonBackgroundColor: .gray,
                                 disableButtonTitleColor: .black,
                                 checkboxColor: .black)

Yuno.initialize(
    apiKey: apiKey,
    config: YunoConfig(appearance: appearance)
)
```

##### Keep loader
By default, Yuno will stop the loading after processing transaction operations.
You can make it persist via YunoConfig by setting `keepLoader: true`.

```swift
Yuno.initialize(
    apiKey: apiKey,
    config: YunoConfig(keepLoader: true)
)
```

This will make the loader persist until you call either of the following functions.
This only apply to payment flow

```swift
Yuno.hideLoader()
```

or

```swift
Yuno.continuePayment(showPaymentStatus: Bool)
```

## Functions

### Enroll a new payment method
To display a view controller with the flow to enroll a new payment method, call the following method:
```swift
protocol YunoEnrollmentDelegate: AnyObject {

    var customerSession: String { get }
    var countryCode: String { get }
    var language: String { get }
    func yunoEnrollmentResult(_ result: Yuno.Result)
}

class ViewController: YunoEnrollmentDelegate {

    @IBAction func startEnrollment(sender: Any) {
        Yuno.enrollPayment(with: self, showPaymentStatus: Bool)
    }
}
```

> Note: showPaymentStatus by default is true

### Checkout
To start a new payment process, it is necessary to call the following method with a payment delegate as a parameter
```swift
protocol YunoPaymentDelegate: AnyObject {

    var checkoutSession: String { get }
    var countryCode: String { get }
    var language: String? { get }
    var viewController: UIViewController? { get }

    func yunoCreatePayment(with token: String)
    func yunoPaymentResult(_ result: Yuno.Result)
}

class ViewController: YunoPaymentDelegate {

    func viewDidLoad() {
        super.viewDidLoad()
    }
}
```
#### Show Payment Methods
When you implement a SDK Full you have to add the next view on your layout to show the payment methods available.

Your delegate must conform to `YunoPaymentFullDelegate` (extends `YunoPaymentDelegate`):

```swift
@objc protocol YunoPaymentFullDelegate: YunoPaymentDelegate {
    func yunoDidSelect(paymentMethod: PaymentMethodSelected)
    func yunoDidUnenrollSuccessfully(_ success: Bool)
    func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat)
}
```

**UIKit** — returns a `UIView`:
```swift
Task {
    let view = await Yuno.getPaymentMethodViewAsync(delegate: self)
    containerView.addSubview(view)
}
```

**SwiftUI** — returns a SwiftUI view:
```swift
.task {
    paymentMethodsView = await Yuno.getPaymentMethodViewAsync(delegate: coordinator)
}
```

#### Start Payment
To start a payment process you have to call the method `startPayment` but if your are using the lite version you must to call `startPaymentLite`
```swift
Yuno.startPayment(showPaymentStatus: Bool)
```
for the Lite version you need to send an additional parameter, these consist, the vaulted token and/or payment type with which the user will pay

```swift
protocol PaymentMethodSelected {
    var vaultedToken: String? { get }
    var paymentMethodType: String { get }
}

Yuno.startPaymentLite(paymentSelected: PaymentMethodSelected, showPaymentStatus: Bool)
```
At the end of this process you will obtain the One Time Token to create back-back the payment, this data you can obtain from the callback of the delegate.

You can get some information like OTT after call a `startPayment` or `startPaymentLite` method, how is showing in the next code:

```swift
func yunoCreatePayment(with token: String) { ... }
```
#### Complete Payment
If the payment required a start an action to complete the payment, you can call the following method to execute the payment and get state of the transaction
```swift
Yuno.continuePayment(showPaymentStatus: Bool)
```

> showPaymentStatus by default is true

#### Callback
The transactions return a `Yuno.Result` whose `status` describes the outcome
(`succeeded`, `fail`, `processing`, `reject`, `internalError`, `userCancelled`)
and `substatus` carries an optional provider-specific reason string. Implement
the delegate to receive it:
```swift
extension Yuno.Result {
    @objc public class Result {
        public let status: Status
        public let substatus: String?

        @objc public enum Status: Int {
            case reject, succeeded, fail, processing, internalError, userCancelled
        }
    }
}

func yunoPaymentResult(_ result: Yuno.Result) {
    switch result.status {
    case .succeeded: break
    case .fail, .reject: break
    case .processing: break
    case .userCancelled, .internalError: break
    @unknown default: break
    }
}

func yunoEnrollmentResult(_ result: Yuno.Result) { /* same shape */ }
```
## Author

Yuno Payments Inc.

## License

YunoSDK is available under the MIT license. See the LICENSE file for more info.
