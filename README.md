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
pod 'YunoSDK'
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

Yuno.initialize(apiKey: "<Your iOS API Key>", forAppId: "<Your App ID>")
```

#### Start enrollment

To display a ViewController of Enrollment flow call the following method:

```swift
let configuration = YunoEnrollmentConfiguration(
    sessionId: "<Your SessionId>",
    paymentId: "<Your PaymentId>",
    navigationController: self.navigationController,
    callbackDelegate: self
)
Yuno.startEnrollment(with: configuration)
```
#### Start payment

To display a ViewController of Payment flow call the following method:

```swift
let configuration = YunoPaymentConfiguration(
    sessionId: "<Your SessionId>",
    paymentId: "<Your PaymentId>",
    navigationController: self.navigationController,
    callbackDelegate: self
)
Yuno.startPayment(with: configuration)
```

## Author

Yuno Payments Inc.

## License

YunoSDK is available under the MIT license. See the LICENSE file for more info.