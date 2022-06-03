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
pod 'YunoSDK', '0.1.2'
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

Yuno.initialize(apiKey: "<Your API Key>")
```

#### Start enrollment

To display a ViewController of Enrollment flow call the following method:

```swift

protocol EnrollmentMethodSelected {
    var type: String { get }
}

class AnyClassDelegate: YunoEnrollmentDelegate {

    let countryCode: String = "<Your country code>" // ISO: CO, AR, BR, etc.
    let customerSession: String = "<Your customer session>"

    var enrollmentSelected: EnrollmentMethodSelected?
    weak var navigationController: UINavigationController?
    
    func yunoEnrollmentResultSuccess() {
        // TODO: Write your code
    }

    func yunoEnrollmentResultError() {
        // TODO: Write your code
    }

    func yunoEnrollmentResultCanceled() {
        // TODO: Write your code
    }

    Yuno.startEnrollment(with: self)
}
```
> If your implementation is Lite (without list the payment methods), please declare: 
    `let isLite: Bool = true`

#### Start payment

To display a ViewController of Payment flow call the following method:

```swift

protocol PaymentSelected {
    var id: String { get }
    var type: String { get }
}

final class AnyClassDelegate: YunoPaymentDelegate {
    
    let countryCode: String = "<Your country code>" // ISO: CO, AR, BR, etc.
    let checkoutSession: String = "<Your checkout session>"
    var paymentSelected: PaymentSelected?
    
    weak var navigationController: UINavigationController?

    func yunoPaymentResultSuccess() {
        // TODO: Write your code
    }

    func yunoPaymentResultError() {
        // TODO: Write your code
    }

    func yunoPaymentResultCanceled() {
        // TODO: Write your code
    }

    private func startPaymentWithYuno() {
        Yuno.startPayment(with: self) { [weak self] (token: String, completion: () -> Void) in
            self?.makePayBackToBack(token, completion: completion)
        }
    }

    private func makePayBackToBack(token: String, completion: () -> Void) {
        //Method to create payment
        completion()
    }
}
```

## Author

Yuno Payments Inc.