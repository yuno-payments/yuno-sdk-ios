# YunoSDK

[![Version](https://img.shields.io/cocoapods/v/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![License](https://img.shields.io/cocoapods/l/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![Platform](https://img.shields.io/cocoapods/p/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![iOS Minimum Deploy Target - 13.0](https://img.shields.io/static/v1?label=iOS+Minimum+Deploy+Target&message=13.0&color=2ea44f)](https://)


A fast checkout that integrates your company to the payments and fraud ecosystem.
‍
Checkout + Routing + Reconciliations + Alternative Payment Methods

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

To integrate Yuno SDK with Cocoapods, please add the line below to your Podfile and run pod install.

```ruby
pod 'YunoSDK', '~> 2.2.2'
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

## Usage
YunoSDK minimum required version is iOS 13.0

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
    var navigationController: UINavigationController? { get }

    func yunoCreatePayment(with token: String)
    func yunoPaymentResult(_ result: Yuno.Result)
}

class ViewController: YunoPaymentDelegate {

    func viewDidLoad() {
        super.viewDidLoad()
        Yuno.startCheckout(with: self)
    }
}
```
#### Show Payment Methods
When you implement a SDK Full you have to add the next view on your layout to show the payment methods available
```swift
Yuno.methodsView(delegate: self)
    generator.getPaymentMethodsView(checkoutSession: checkoutSession) { [weak self] (view: UIView) in
        // Add view to your superview
    }
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
The transactions could return three different states: success, fail, processing and reject, to listen this state you have to implement the delegate, like in the follow piece of code:
```swift
enum Result {
    case reject, success, fail, processing, internalError, userCancell
}

func yunoPaymentResult(_ result: Yuno.Result) { ... }
func yunoEnrollmentResult(_ result: Yuno.Result) { ... }
```
## Author

Yuno Payments Inc.

## License

YunoSDK is available under the MIT license. See the LICENSE file for more info.
