# Headless SDK (Payment)

[![Version](https://img.shields.io/cocoapods/v/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![License](https://img.shields.io/cocoapods/l/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![Platform](https://img.shields.io/cocoapods/p/YunoSDK.svg?style=flat)](https://cocoapods.org/pods/YunoSDK)
[![iOS Minimum Deploy Target - 13.0](https://img.shields.io/static/v1?label=iOS+Minimum+Deploy+Target&message=13.0&color=2ea44f)](https://)


Yuno's Headless SDK lets you enroll in payment methods and tokenize cards, saving them for future use. However, for more frictionless integration, Yuno recommends using one of the other SDK implementations, such as Full or Lite.

The following steps describe enrolling a payment method using Yuno's Headless SDK.


## Requirements

To execute the enrollment process, you need to provide the customer_session to start the enrollment process in Step 3. To acquire the customer_session, you need to:

* Create a customer: A customer is required to enroll in payments. Use the Create Customer endpoint to create new customers. In the response, you will receive the customer id, which you use to create the customer session.
* Create the customer session: Use the customer id and the Create Customer Session endpoint to receive the customer_session.



## Step 1: Initialize Headless SDK with the public key

To initialize the Headless SDK, you need to import Yuno and provide a valid PUBLIC_API_KEY. If you don't have your API credentials, access the [Developers (Credentials)](https://docs.y.uno/docs/developers-credentials) page to check how to retrieve them from the dashboard.


> Note: If your app is using a UISceneDelegate you will need to put your Yuno initialisation code into your SceneDelegate

```swift
import YunoSDK

Yuno.initialize(
    apiKey: "<Your iOS API Key>"
)
```

## Step 2: Create a customer session

To start the enrollment process, you need to provide the customer_session. First, you need to create a customer. You need a customer to enroll payments with. Use the Create Customer endpoint to create new customers. In the response, you will receive the customer id, which you use to create the customer session.

After creating the customer, you can create the customer session. Use the customer id and the Create Customer Session endpoint. The customer_session will be provided in the response. You need a new customer_session every time you enroll in a new payment method

## Step 3: Start the enrollment process

Next, you will start the checkout process using the apiClientEnroll function, providing the necessary configuration parameters. The following table lists all required parameters and their descriptions.

| Parameter        | Description                                                                  |
|--------------    |----------------------------------------------------------------------------- |
| country_code     | This parameter determines the country for which the payment process is being configured .The complete list of supported countries and their country_code  is available on the [Country coverage](https://docs.y.uno/docs/country-coverage-yuno-sdk)  page.                  |
| customer_session | Refers to the current enrollment's customer session received as a response to the Create Customer Session endpoint. Example: '438413b7-4921-41e4-b8f3-28a5a0141638'   |

The next code block presents an example of the parameter configuration.

```swift

var apiClientEnroll: YunoEnrollHeadless?

apiClientEnroll = Yuno.apiClientEnroll(

  /**
     * country can be one of the following: https://docs.y.uno/docs/country-coverage-yuno-sdk
     */
    country_code: "CO",
     /**
     * The customer_session created in https://docs.y.uno/reference/create-customer-session
     */
    customer_session: "eec6578e-ac2f-40a0-8065-25b5957f6dd3"
  )

```


## Step 5: Generate a vaulted token

After collecting all user information, you can start the enrollment. First, you need to create a vaulted_token using the function apiClientEnroll.continueEnrollment. As it is an asynchronous function, you can use do/catch to ensure you will correctly handle triggered errors. Below, you will find an example of creating a vaulted_token:

```swift
/**
 * Create Token
 * This function will trigger an error if there is missing data.
 * You can catch this error using a do/catch block.
 */
// `EnrollmentCollectedData` is a public data type that contains the necessary information for the payment structure.
let enrollmentCollectedData: EnrollmentCollectedData = EnrollmentCollectedData(
    // The customer_session created in https://docs.y.uno/reference/create-customer-session
    customerSession: "eec6578e-ac2f-40a0-8065-25b5957f6dd3",
    // The necessary info to use the payment method structure
    paymentMethod: CollectedData(
        type: "CARD",
        card: CardData(
            detail: CardData.Detail(
                number: "4111111111111111",
                expirationMonth: 12,
                expirationYear: 25,
                securityCode: "123",
                holderName: "Andrea",
                // Use `.debit` or `.credit` for the card type.
                type: .credit
            )
        ),
        customer: Customer(
            // Add the complete customer object here.
            // You can check the object here: https://docs.y.uno/reference/the-customer-object
            // You create the customer using the following endpoint: https://docs.y.uno/reference/create-customer
        )
    )
)

let result = try await apiClientEnroll.continueEnrollment(data: enrollmentCollectedData)
```

After enrolling the new card, you will receive the vaulted_token, which you can use to make payments in the future without asking for your customer's card information. The following code block presents an example of a response from the apiClientEnroll.continueEnrollment function. The response is a dictionary of type [String: Any].

```swift
[
 vaulted_token: "9104911d-5df9-429e-8488-ad41abea1a4b",
 status: "ENROLLED",

//Same status for all SDKs: CREATED,
    EXPIRED,
    REJECTED,
   
 READY_TO_ENROLL,
    ENROLL_IN_PROCESS,
    UNENROLL_IN_PROCESS,
    IN_PROCESS,
    ENROLLED,
    DECLINED,
    CANCELED,
    ERROR,
    UNENROLLED;
 customer: [
   session: "eec6578e-ac2f-40a0-8065-25b5957f6dd3"
 ]
]
```
