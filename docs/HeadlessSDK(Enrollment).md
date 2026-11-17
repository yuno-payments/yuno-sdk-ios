# Headless SDK (Enrollment)

With Yuno's Headless SDK your app builds the enrollment UI and collects the card details, and the SDK enrolls (vaults) the card so you can charge it later with its `vaultedToken`, without asking the customer for the card again. For a simpler integration, Yuno recommends the Full or Lite flows.

Official reference: [Headless SDK (Enrollment iOS)](https://docs.y.uno/docs/sdks/headless-ios/enrollment).

## Requirements

- iOS 14.0+, Xcode 26.2+, Swift 5.7+.
- The SDK installed with Swift Package Manager (`https://github.com/yuno-payments/yuno-sdk-ios.git`, product `YunoSDK` or `YunoSDK-Static`). See [README.md](../README.md#installation) and [AGENTS.md](../AGENTS.md#install).
- A customer session created by your backend:
  1. Create the customer with the [Create Customer](https://docs.y.uno/reference/create-customer) endpoint and keep its `id`.
  2. Create the customer session with that `id` and the [Create Customer Session](https://docs.y.uno/reference/create-customer-session) endpoint. Use a new customer session for every enrollment.

## Step 1: Initialize the SDK with your public API key

Import `YunoSDK` and initialize it with your public API key. To get your credentials, see [Developers (Credentials)](https://docs.y.uno/docs/developers-credentials).

> If your app uses a `UISceneDelegate`, initialize Yuno from your `SceneDelegate`.

```swift
import YunoSDK

Yuno.initialize(apiKey: "<YOUR_PUBLIC_API_KEY>")
```

## Step 2: Create the enrollment headless client

| Parameter | Description |
|---|---|
| `countryCode` | Country of the enrollment, for example `CO`. See [Country coverage](https://docs.y.uno/docs/country-coverage-yuno-sdk). |
| `customerSession` | The customer session your backend created for this enrollment. |

```swift
var apiClientEnroll: YunoEnrollHeadless?

do {
    apiClientEnroll = try Yuno.apiClientEnroll(
        countryCode: "CO",
        customerSession: "<CUSTOMER_SESSION>"
    )
} catch {
    // Handle the error
}
```

## Step 3: Enroll the card

Call `continueEnrollment(data:)` with the collected card details. It is an `async throws` function. Card details are required.

```swift
let enrollmentCollectedData = EnrollmentCollectedData(
    customerSession: "<CUSTOMER_SESSION>",
    paymentMethod: CollectedData(
        type: "CARD",
        card: CardData(
            detail: CardData.Detail(
                number: cardNumber,              // values your form collected
                expirationMonth: expirationMonth,
                expirationYear: expirationYear,
                securityCode: securityCode,
                holderName: holderName,
                type: .credit                    // .credit, .debit or .none
            )
        ),
        customer: nil                            // or a Customer(...) when the provider requires customer data
    )
)

do {
    let result = try await apiClientEnroll?.continueEnrollment(data: enrollmentCollectedData)
    let vaultedToken = result?["vaultedToken"]
    let status = result?["status"]
} catch {
    // Handle the error (see "Errors")
}
```

The types are the same as in the payment guide; see [Types used](HeadlessSDK(Payment).md#types-used). `EnrollmentCollectedData` is `init(customerSession: String, paymentMethod: CollectedData)`.

### Response

`continueEnrollment(data:)` returns `[String: String]` with these keys:

| Key | Value |
|---|---|
| `vaultedToken` | The vaulted token of the enrolled card |
| `status` | The enrollment status, for example `ENROLLED` |
| `customerSession` | The customer session used |

Base business decisions on the enrollment status your backend receives through [webhooks](https://docs.y.uno/docs/webhooks).

## Errors

`continueEnrollment(data:)` and `Yuno.apiClientEnroll(countryCode:customerSession:)` throw. SDK errors are `YunoEnrollHeadlessError`, whose only case is `.internalError`.

## Reference code

The example apps in this repository show the Full, Lite, Render and Enrollment flows; see [AGENTS.md](../AGENTS.md#reference-code).
