# Headless SDK (Payment)

[![Version](https://img.shields.io/cocoapods/v/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![License](https://img.shields.io/cocoapods/l/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![Platform](https://img.shields.io/cocoapods/p/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![iOS Minimum Deploy Target - 13.0](https://img.shields.io/static/v1?label=iOS+Minimum+Deploy+Target&message=13.0&color=2ea44f)](https://)


Yuno's Headless SDK lets you create payments and enroll payment methods simultaneously. Note that when using the Headless SDK, you will need to request and send via API all the mandatory fields the payment provider requires to generate payment in their API. Yuno recommends using one of the other SDK implementations, such as Full or Lite, for more frictionless integration.


Yuno's Headless SDK enables you to create payments in two different scenarios:

* Create a One-Time Use Token using credit card information, then create a payment.
* Create a One-Time Use Token using a vaulted_token from a previously enrolled credit card, then create a payment.

The following steps describe creating a payment using Yuno's Headless SDK.

## Step 1: Initialize Headless SDK with the public key

To initialize the Headless SDK, you need to import Yuno and provide a valid PUBLIC_API_KEY. If you don't have your API credentials, access the [Developers (Credentials)](https://docs.y.uno/docs/developers-credentials) page to check how to retrieve them from the dashboard.


> Note: If your app is using a UISceneDelegate you will need to put your Yuno initialisation code into your SceneDelegate

```swift
import YunoSDK

Yuno.initialize(
    apiKey: "<Your iOS API Key>"
)
```

## Step 2: Start the checkout process

Next, you will start the checkout process using the apiClientPayment function, providing the necessary configuration parameters. You need to call this function once your customer selects the payment method. As a result, the SDK will start collecting relevant information for 3DS and fraud prevention tools you have configured in your routing.

| Parameter        | Description                                                                  |
|--------------    |----------------------------------------------------------------------------- |
| country_code     | This parameter determines the country for which the payment process is being configured .The complete list of supported countries and their country_code  is available on the [Country coverage](https://docs.y.uno/docs/country-coverage-yuno-sdk)  page.                  |
| checkout_session | Refers to the current payment's checkout session created using the Create Checkout Session endpoint. Example: '438413b7-4921-41e4-b8f3-28a5a0141638'   |

The following code block presents an example of the parameter configuration.

```swift

var apiClientPayment: YunoPaymentHeadless?

apiClientPayment = Yuno.apiClientPayment(
                    countryCode: "CO",
                    checkoutSession: "438413b7-4921-41e4-b8f3-28a5a0141638"
                )

```



## Step 4: Generate an OTT (One-Time Token)
After collecting all user information, you can start the payment. First, you need to create an OTT using the function apiClientpayment.generateToken. As it is an asynchronous function, you can use try/catch to ensure you will correctly handle triggered errors. Below, you will find three examples of different scenarios to create the OTT:

* Example 1: Create an OTT utilizing a card as the payment method and including all requisite card information.
* Example 2: Create an OTT using the vaulted_token information.



## Example

After collecting all user information, you can start the payment. First, you need to create an OTT using the function apiClientPayment.generateToken. As it is an asynchronous function, you can use do/catch to ensure you will correctly handle triggered errors. Below, you will find two examples of different scenarios to create an OTT:

* Example 1: Create an OTT utilizing a card as the payment method and including all requisite card information.

```swift
// CollectedData is a public data type with the necessary info for the payment structure

let tokenCollectedData: TokenCollectedData = TokenCollectedData(
      // The checkout_session created using the following endpoint https://docs.y.uno/reference/create-checkout-session
    checkoutSession: "438413b7-4921-41e4-b8f3-28a5a0141638",
        // collectedData: The necessary info to use the payment method structure
      paymentMethod: CollectedData(
        type: "CARD",
        // Optional
                 // Send this value if you already have a registered or enrolled payment method.
        // Other fields like card and customer are optional unless your provider requires them.
        vaultedToken: nil,
        card: CardData(
            // Optional
            // Set this value to “true” if you want to generate a vaulted_token (tokenize) the card.
            save: true,
            detail: CardData.Detail(
                number: "4111111111111111",
                expirationMonth: 12,
                expirationYear: 25,
                securityCode: "123",
                holderName: "Andrea",
                // .debit or .credit
                type: .credit
            ),
            // Optional
            // Only necessary if an installments plan is created for the account.
            installment: CardData.Installment(
                id: "64ceacef-0886-4c81-9779-b2b3029c4e8b",
                value: 1
            )
        ),
      
        customer: Customer(
            // Add the complete customer object here.
                  // You can check the object here: https://docs.y.uno/reference/the-customer-object
                  // You create the customer using the following endpoint: https://docs.y.uno/reference/create-customer
        )
    )
)

let result = try await apiClientPayment.generateToken(
    data: tokenCollectedData
)

```

* Example 2: Create an OTT using the vaulted_token information.


```swift
// CollectedData is a public data type with the necessary info for the payment structure
let tokenCollectedData: TokenCollectedData = TokenCollectedData(
    // The checkout_session created using the following endpoint https://docs.y.uno/reference/create-checkout-session
    checkoutSession: "438413b7-4921-41e4-b8f3-28a5a0141638",
        // collectedData: The necessary info to use the payment method structure
    paymentMethod: CollectedData(
        type: "CARD",
        // Optional
        // Optional
                 // Send this value if you already have a registered or enrolled payment method.
        // Other fields like card and customer are optional unless your provider requires them.
        vaultedToken: "c8bb2bd8-8abf-4265-b478-0ec4e3c10cd5",
        card: CardData(
            // Optional
            // Only necessary if an installments plan is created for the account.
            installment: CardData.Installment(
                id: "64ceacef-0886-4c81-9779-b2b3029c4e8b",
                value: 1
            )
        ),
        customer: Customer(
            // Add the complete customer object here.
                  // You can check the object here: https://docs.y.uno/reference/the-customer-object
                  // You create the customer using the following endpoint: https://docs.y.uno/reference/create-customer
        )
    )
)

///   - checkoutSession: The optional checkout_session created using the following endpoint https://docs.y.uno/reference/create-checkout-session
///   - collectedData: The necessary info to use the payment method structure
let result = try await apiClientPayment.generateToken(
    data: tokenCollectedData
)

```

The following code block presents the apiClientPayment.generateToken function responses for both examples above. The response is a dictionary of type [String: Any].

* Example 1:
```
 ["token": "9ee44ac7-9134-4598-ae28-a26fec03099d",
     "type": "CARD",
     "customer": ["billing_address": nil,
                  "first_name": nil,
                  "gender": "",
                  "phone": nil,
                  "browser_info": ["color_depth": nil,
                                   "language": "en",
                                   "accept_header": "*/*",
                                   "browser_time_difference": nil,
                                   "accept_content": nil,
                                   "accept_browser": nil,
                                   "java_enabled": nil,
                                   "user_agent": "YunoSDK_Example/1 CFNetwork/1406.0.4 Darwin/22.6.0",
                                   "screen_height": "844.0",
                                   "screen_width": "390.0",
                                   "javascript_enabled": nil],
                  "document": nil,
                  "last_name": nil,
                  "device_fingerprint": nil,
                  "email": nil],
     "country": "BR",
     "vaulted_token": nil,
     "installment": ["rate": "",
                     "id": "cca80084-961b-4212-9c34-54f03f4f10ae",
                     "value": 24,
                     "amount": nil],
     "card_data": nil]
```

* Example 2:

```
["token": "9ee44ac7-9134-4598-ae28-a26fec03099d",
     "type": "CARD",
     "customer": ["billing_address": nil,
                  "first_name": nil,
                  "gender": "",
                  "phone": nil,
                  "browser_info": ["color_depth": nil,
                                   "language": "en",
                                   "accept_header": "*/*",
                                   "browser_time_difference": nil,
                                   "accept_content": nil,
                                   "accept_browser": nil,
                                   "java_enabled": nil,
                                   "user_agent": "YunoSDK_Example/1 CFNetwork/1406.0.4 Darwin/22.6.0",
                                   "screen_height": "844.0",
                                   "screen_width": "390.0",
                                   "javascript_enabled": nil],
                  "document": nil,
                  "last_name": nil,
                  "device_fingerprint": nil,
                  "email": nil],
     "country": "BR",
     "vaulted_token": "a1c7c5d1-b260-4dc6-909a-8368704233cf",
     "installment": ["rate": "",
                     "id": "cca80084-961b-4212-9c34-54f03f4f10ae",
                     "value": 24,
                     "amount": nil],
     "card_data": nil]
```


## Step 4: Create the payment

After receiving the OTT, you can create the payment using the Create Payment endpoint to get the final payment result. You will inform the OTT received in Step 4 through the request's payment_method.token parameter

For more information about the payment process, please visit our [documentation page](https://docs.y.uno/docs/headless-sdk-payment-ios)


## Step 5: Get the 3DS challenge URL

A payment with 3DS may require an additional challenge to check the customer's identity, as described on the 3DS Card Verification (old version) page. If an additional verification step is necessary related to a 3DS verification challenge, the Create Payment endpoint response will contain:

Status equal to PENDING and sub status equal to WAITING_ADDITIONAL_STEP.
sdk_action_required = true.
A redirect_url defined in payment.payment_method.payment_method_detail.card.
As a result, you need to redirect your customer to the challenge URL. To get the 3DS challenge URL, you need to call the getThreeDSecureChallenge function, providing the checkoutSession. The checkoutSession is only required if you aren't using the one used to create the payment. Below, you will find an example of using the getThreeDSecureChallenge function. As getThreeDSecureChallenge is an asynchronous function, you can use do/catch to ensure you will correctly handle triggered errors.


```swift

func getThreeDSecureChallenge(checkoutSession: String?) async throws -> ThreeDSecureChallengeResponse

```

The getThreeDSecureChallenge function will return the ThreeDSecureChallengeResponse, presented in the next code block:

```swift

struct ThreeDSecureChallengeResponse {
    let url: String
}
```

The url will contain a valid URL you need to redirect your customer to complete the challenge.

You are responsible for redirecting your customers to the URL provided by the getThreeDSecureChallenge() function to complete the challenge. Once the customer successfully completes the 3DS challenge, they will be automatically redirected to the callback_url, which you provided when creating the checkout_session with the Create Checkout Session endpoint.

To confirm the challenge was completed, you can open a web view to load the provided URL and listen for the messageFromWeb event. Below is an example code demonstrating how to listen for this event.

```swift
class HeadlessWebView: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {

    private var webView: WKWebView!
    private var url: String = ""
    private let configuration = WKWebViewConfiguration()

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webViewConfig()
    }

    func webViewConfig() {
   
        configuration.preferences.javaScriptEnabled = true
        configuration.userContentController.add(self, name: "messageFromWeb")
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self

        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)

        // Add the webview, and set constraints
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "messageFromWeb", let messageBody = message.body as? String {
            // Handle response 'messageBody'
            // Possible responses from the webview
            self.dismiss(animated: true)

        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.configuration.userContentController.removeScriptMessageHandler(forName: "messageFromWeb")
    }

}

```

The response will inform the challenge status, which can be COMPLETED or ERROR. The next code block presents examples for each possible option.

```
// Challenge completed
{
   "origin":"CHALLENGE",
   "status":"COMPLETED",
   "data":"callback_url"
}
```

```
// Challenge error
{
   "origin":"CHALLENGE",
   "status":"ERROR",
   "data":"Invalid 3DS provider"
}

```

To complete the Headless SDK payment flow, you need to use Yuno Webhooks, which will promptly notify you about the outcome of the 3DS challenge and the final payment status. Using webhooks ensures that you receive real-time updates on the progress of the payment transaction. In addition to the webhooks, you can retrieve the payment information using the Retrieve Payment by ID endpoint.
