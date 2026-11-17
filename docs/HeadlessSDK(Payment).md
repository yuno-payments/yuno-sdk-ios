# Headless SDK (Payment)

With Yuno's Headless SDK your app builds the whole payment UI and collects the data itself, and the SDK turns that data into a one-time token (OTT), collecting the 3DS and fraud prevention information configured in your routing. You must collect and send every field the payment provider requires. For a simpler integration, Yuno recommends the Full or Lite flows.

The Headless SDK creates a one-time token in two scenarios:

* From card details your app collected.
* From a `vaultedToken` of a previously enrolled card.

Your backend then creates the payment with the token. If the payment needs more steps (for example a 3DS challenge), the SDK completes them with `continueCardPayment(onResult:)`.

Official reference: [Headless SDK (Payment iOS)](https://docs.y.uno/docs/sdks/headless-ios/checkout).

## Requirements

- iOS 14.0+, Xcode 26.2+, Swift 5.7+.
- The SDK installed with Swift Package Manager (`https://github.com/yuno-payments/yuno-sdk-ios.git`, product `YunoSDK` or `YunoSDK-Static`). See [README.md](../README.md#installation) and [AGENTS.md](../AGENTS.md#install).
- A checkout session created by your backend with the [Create Checkout Session](https://docs.y.uno/reference/create-checkout-session) endpoint.

## Step 1: Initialize the SDK with your public API key

Import `YunoSDK` and initialize it with your public API key. To get your credentials, see [Developers (Credentials)](https://docs.y.uno/docs/developers-credentials).

> If your app uses a `UISceneDelegate`, initialize Yuno from your `SceneDelegate`.

```swift
import YunoSDK

Yuno.initialize(apiKey: "<YOUR_PUBLIC_API_KEY>")
```

## Step 2: Create the payment headless client

Create the client once the customer has selected the payment method. The SDK starts collecting the 3DS and fraud prevention data configured in your routing.

| Parameter | Description |
|---|---|
| `countryCode` | Country of the payment, for example `CO`. See [Country coverage](https://docs.y.uno/docs/country-coverage-yuno-sdk). |
| `checkoutSession` | The checkout session your backend created for this payment. |

```swift
var apiClientPayment: YunoPaymentHeadless?

do {
    apiClientPayment = try Yuno.apiClientPayment(
        countryCode: "CO",
        checkoutSession: "<CHECKOUT_SESSION>"
    )
} catch {
    // Handle the error
}
```

Keep a strong reference to the client: you use the same instance to generate the token and to continue the payment.

## Step 3: Generate a one-time token

Call `generateToken(data:)` with the collected data. It is an `async throws` function.

### Example 1: card details

```swift
let tokenCollectedData = TokenCollectedData(
    checkoutSession: "<CHECKOUT_SESSION>",
    paymentMethod: CollectedData(
        type: "CARD",
        vaultedToken: nil,
        card: CardData(
            save: true,                          // true to also vault (enroll) the card
            detail: CardData.Detail(
                number: cardNumber,              // values your form collected
                expirationMonth: expirationMonth,
                expirationYear: expirationYear,
                securityCode: securityCode,
                holderName: holderName,
                type: .credit                    // .credit, .debit or .none
            ),
            installment: CardData.Installment(   // only if an installment plan applies
                id: "<INSTALLMENT_PLAN_ID>",
                value: 1
            )
        ),
        customer: nil                            // or a Customer(...) when the provider requires customer data
    )
)

do {
    let result = try await apiClientPayment?.generateToken(data: tokenCollectedData)
    let oneTimeToken = result?["token"] as? String
    // Send oneTimeToken to your backend
} catch {
    // Handle the error (see "Errors")
}
```

### Example 2: vaulted token

A vaulted token still goes through the SDK, so the fraud data of your configured providers is attached to the one-time token. Add the installment or the security code when the provider requires them.

```swift
let tokenCollectedData = TokenCollectedData(
    checkoutSession: "<CHECKOUT_SESSION>",
    paymentMethod: CollectedData(
        type: "CARD",
        vaultedToken: "<VAULTED_TOKEN>",
        card: CardData(
            installment: CardData.Installment(
                id: "<INSTALLMENT_PLAN_ID>",
                value: 1
            )
        ),
        customer: nil
    )
)

let result = try await apiClientPayment?.generateToken(data: tokenCollectedData)
```

### Response

`generateToken(data:)` returns the one-time token response as `[String: Any]`. Read the token from the `token` key. The dictionary also carries other fields of the token response, such as `type`, `vaulted_token`, `customer` and `installment`.

### Types used

| Type | Initializer |
|---|---|
| `TokenCollectedData` | `init(checkoutSession: String, paymentMethod: CollectedData)` |
| `CollectedData` | `init(type: String = "CARD", vaultedToken: String? = nil, card: CardData, customer: Customer?)` |
| `CardData` | `init(save: Bool = false, detail: CardData.Detail? = nil, installment: CardData.Installment? = nil)` |
| `CardData.Detail` | `init(number: String? = nil, expirationMonth: Int = 0, expirationYear: Int = 0, securityCode: String? = nil, holderName: String? = nil, brand: String? = nil, type: CardData.CardType = .none)` |
| `CardData.Installment` | `init(id: String, value: Int)` |
| `CardData.CardType` | `.none`, `.debit`, `.credit` |
| `Customer` | `init(id:merchantCustomerId:firstName:lastName:gender:dateOfBirth:email:nationality:country:document:phone:billingAddress:shippingAddress:neighborhood:)`, every parameter optional. See [the customer object](https://docs.y.uno/reference/the-customer-object) |

## Step 4: Create the payment from your backend

Your backend creates the payment with the [Create Payment](https://docs.y.uno/reference/create-payment) endpoint, sending the one-time token in `payment_method.token`. Never create payments from the app: the private secret key must stay on your server.

## Step 5: Continue the payment (3DS and other actions)

If the payment needs more steps, for example a 3DS challenge, call `continueCardPayment(onResult:)` on the same client after your backend created the payment:

```swift
func continueCardPayment(onResult: @escaping (Yuno.Result) -> Void)
```

The SDK checks the payment state of the checkout session, runs the remaining actions (it presents the 3DS challenge on top of your app's current screen), listens for the transaction result, and delivers every status through `onResult` on the main thread. `onResult` can be called more than once: an intermediate `.processing`, then a terminal status.

Only `CARD` payments are supported.

```swift
apiClientPayment?.continueCardPayment { result in
    switch result.status {
    case .processing:
        // Still in progress; wait for the next call
        break
    case .succeeded:
        break
    case .reject, .fail:
        break
    case .userCancelled:
        break
    case .internalError:
        break
    @unknown default:
        break
    }
    // result.substatus and result.message carry extra detail when available
}
```

Use [webhooks](https://docs.y.uno/docs/webhooks) on your backend as the source of truth for the final payment status. You can also query the payment with the Retrieve Payment endpoints.

## Errors

`generateToken(data:)` and `Yuno.apiClientPayment(countryCode:checkoutSession:)` throw. SDK errors are `YunoPaymentHeadlessError`:

| Case | Meaning |
|---|---|
| `.antifraudTimeout` | The fraud prevention data could not be collected in time |
| `.invalidProviderUrl` | The provider URL returned for the payment is not valid |
| `.internalError` | The SDK could not complete the request |

## Reference code

The example apps in this repository show the Full, Lite, Render and Enrollment flows; see [AGENTS.md](../AGENTS.md#reference-code).
