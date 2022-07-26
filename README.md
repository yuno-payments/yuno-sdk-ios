# YunoSDK

[![Version](https://img.shields.io/cocoapods/v/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![License](https://img.shields.io/cocoapods/l/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![Platform](https://img.shields.io/cocoapods/p/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)

A fast checkout that integrates your company to the payments and fraud ecosystem.
‍
Checkout + Routing + Reconciliations + Alternative Payment Methods

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

To integrate Yuno SDK with Cocoapods, please add the line below to your Podfile and run pod install. 

```ruby
pod 'YunoSDK', '~> 1.0.6'
```

Then run pod install in your directory:

```shell
$ pod install
```

## Usage

First, you'll need to get your Yuno app ID and iOS API key, Then, Then initialize Yuno by importing Yuno and adding the following to your application delegate:

> If your app is using a UISceneDelegate you will need to put your Yuno initialisation code into your SceneDelegate

```swift
import YunoSDK

Yuno.initialize(apiKey: "<Your iOS API Key>")
```

## Functions

### Enroll a new payment method
To display a view controller with the flow to enroll a new payment method, call the following method:
```swift
protocol YunoEnrollmentDelegate: AnyObject {
        
    var customerSession: String { get }
    func yunoEnrollmentResult(_ result: Yuno.Result)
}

class ViewController: YunoEnrollmentDelegate {

    @IBAction func startEnrollment(sender: Any) {
        Yuno.enrollPayment(with: self, showPaymentStatus: Bool)
    }
}
```

> showPaymentStatus by default is true

### Checkout
To start a new payment process, it is necessary to call the following method with a payment delegate as a parameter
```swift 
protocol YunoPaymentDelegate: AnyObject {
        
    var checkoutSession: String { get }
    var countryCode: String { get }
    var language: String { get }
    var navigationController: UINavigationController? { get }
    
    func yunoCreatePayment(with token: String)
    func yunoPaymentResult(_ result: Yuno.Result)
}

class ViewController: YunoEnrollmentDelegate {

    @IBAction func startEnrollment(sender: Any) {
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
Yuno.startPayment()
```
for the Lite version you need to send an additional parameter, these consist, the vaulted token and/or payment type with which the user will pay  

```swift 
protocol PaymentMethodSelected {
    var vaultedToken: String? { get }
    var paymentMethodType: String { get }
}

Yuno.startPaymentLite(paymentSelected: paymentSelected)
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
    case reject, success, fail, processing
}

func yunoPaymentResult(_ result: Yuno.Result) { ... }
func yunoEnrollmentResult(_ result: Yuno.Result) { ... }
```
## Author

Yuno Payments Inc.

## License

YunoSDK is available under the MIT license. See the LICENSE file for more info.
