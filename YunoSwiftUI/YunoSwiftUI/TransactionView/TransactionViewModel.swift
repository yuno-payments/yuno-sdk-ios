//
//  TransactionViewModel.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import Combine
import SdkPayments
import SwiftUI

typealias CustomerData = (id: String?, merchantId: String?)

/// Thrown from the `createPayment(token:)` override so the SDK fails the flow
/// instead of treating a silent early return as a completed merchant payment.
enum MerchantPaymentError: LocalizedError {
    case missingToken
    case cancelled

    var errorDescription: String? {
        switch self {
        case .missingToken: return "One-time token payload has no token string"
        case .cancelled:    return "Merchant cancelled the OTT confirmation"
        }
    }
}

extension TransactionView {

    @MainActor
    class ViewModel: ObservableObject {

        var anyCancellables: Set<AnyCancellable> = []
        @Published var presentOtt: Bool = false
        @Published var ott: String = ""
        let apiKey: String
        var customer: Customer?
        @Published var continuePayment = false
        @Published var renderIsLoading: Bool = false

        @Published var paymentViewHeight: CGFloat = 0

        /// Retained for the duration of a Lite/Full transaction. The SDK holds the
        /// controller weakly, so the transaction (and its config's controller) must be
        /// kept alive here.
        var transaction: SdkPayments.Transaction?
        @Published var selectedPaymentMethod: SdkPayments.PaymentMethodSelected?

        /// Method to pass to `start(paymentSelected:)` for the Lite flow. Built from the
        /// merchant-provided payment type + optional vaulted token.
        var selectedPaymentMethodLite: SdkPayments.PaymentMethodSelected {
            SdkPayments.PaymentMethodSelected(
                paymentMethodType: paymentType,
                vaultedToken: vaultedToken.isEmpty ? nil : vaultedToken
            )
        }

        @Published var paymentListView: AnyView?
        @Published var hasLoadedPaymentMethods = false

        @Published var configLanguage: String = "EN"

        @Published var configCountryCode: String = "CO"

        var language: String? { configLanguage }

        var countryCode: String { configCountryCode }

        @Published var customerSession: String = ""
        @Published var checkoutSession: String = ""
        @Published var paymentType: String = ""
        @Published var vaultedToken: String = ""
        @Published var showSdkFullView: Bool = false
        @Published var showSdkPaymentRenderView: Bool = false
        @Published var showSdkEnrollmentRenderView: Bool = false

        /// The OTT-manual flow suspends the `createPayment(token:)` override on this
        /// continuation while the modal is up. "Continue" resumes it; closing with
        /// cancel/x resumes it throwing so the override throws and the SDK ends the flow.
        private var ottContinuation: CheckedContinuation<Void, Error>?

        init(apiKey: String) {
            self.apiKey = apiKey
        }

        func loadConfiguration() async {
            $continuePayment
                .removeDuplicates()
                .filter { $0 }
                .sink { [weak self] (_: Bool) in
                    self?.resumeOttApproval()
                }
                .store(in: &anyCancellables)

            await initializeYunoSDK()
        }

        func initializeYunoSDK() async {
            await SdkPayments.initialize(apiKey: apiKey)
        }

        /// Per-transaction configuration for payment flows (Lite / Full).
        private func makePaymentConfig() -> SdkPayments.TransactionConfig {
            SdkPayments.TransactionConfig(
                checkoutSession: checkoutSession,
                countryCode: countryCode,
                language: language,
                controller: self,
                showStatusScreen: false
            )
        }

        /// Lite: the merchant pre-selects the method and hands off to the SDK.
        func startLitePayment() {
            let transaction = SdkPayments.Transaction(config: makePaymentConfig())
            self.transaction = transaction
            transaction.start(paymentSelected: selectedPaymentMethodLite)
        }

        /// Enrollment (SDK-driven). The merchant picks the method to enroll and hands
        /// it to `start(paymentSelected:)`; the result arrives via `onStatus`.
        func startEnrollment() {
            let config = SdkPayments.TransactionConfig(
                customerSession: customerSession,
                countryCode: countryCode,
                language: language,
                controller: self,
                showStatusScreen: true
            )
            let transaction = SdkPayments.Transaction(config: config)
            self.transaction = transaction
            transaction.start(
                paymentSelected: SdkPayments.PaymentMethodSelected(
                    paymentMethodType: paymentType
                )
            )
        }

        /// Full-mode entry point: builds the `Transaction`, retains it so it survives
        /// navigation, resets the selection, then flips the navigation flag.
        func loadMethodsView() {
            selectedPaymentMethod = nil
            hasLoadedPaymentMethods = false
            paymentListView = nil
            transaction = SdkPayments.Transaction(config: makePaymentConfig())
            showSdkFullView = true
        }

        /// Renders the SDK's payment-method list (Full mode) into `paymentListView`.
        func loadPaymentMethodsViewIfNeeded() async {
            guard !hasLoadedPaymentMethods, let transaction else { return }
            hasLoadedPaymentMethods = true
            let views = transaction.getPaymentMethodsViews(
                types: [.PAYMENT_METHOD_LIST],
                controller: self
            )
            paymentListView = views[.PAYMENT_METHOD_LIST]
        }

        /// Triggered by the "Pay" button in `PaymentFullView`. Forwards the method the
        /// user picked from the list (received via `onPaymentSelected`) into `start`.
        func startFullPayment() {
            guard let transaction, let selected = selectedPaymentMethod else { return }
            transaction.start(paymentSelected: selected)
        }

        /// Resumes the OTT-manual flow: dismisses the modal and resumes the
        /// `createPayment(token:)` override that suspended waiting for user approval.
        func resumeOttApproval() {
            presentOtt = false
            continuePayment = false
            ottContinuation?.resume(returning: ())
            ottContinuation = nil
        }

        /// Tears down the OTT-manual modal. If the override is still suspended, resumes
        /// it throwing so `createPayment` throws and the SDK ends the flow. Safe to call
        /// repeatedly.
        func cancelOttIfPending() {
            presentOtt = false
            continuePayment = false
            guard let continuation = ottContinuation else { return }
            ottContinuation = nil
            continuation.resume(throwing: MerchantPaymentError.cancelled)
        }

        // MARK: - TransactionController
        // Declared in the class body (not an extension) so the Render subclasses can
        // `override` them — Swift does not allow overriding methods declared in a
        // base-class extension.

        func onStatus(status: SdkPayments.TransactionStatus) {
            switch status.status {
            case "SUCCEEDED":       print(">>>>>>> onStatus Succeeded")
            case "REJECT":          print(">>>>>>> onStatus Reject")
            case "FAIL":            print(">>>>>>> onStatus Fail")
            case "PROCESSING":      print(">>>>>>> onStatus Processing")
            case "INTERNAL_ERROR":  print(">>>>>>> onStatus InternalError")
            case "USER_CANCEL":     print(">>>>>>> onStatus UserCancel")
            default:                print(">>>>>>> onStatus \(status.status)")
            }
            // Tear the manual-OTT modal down and unblock any suspended `createPayment`
            // so neither outlives the flow.
            cancelOttIfPending()
            transaction = nil
            selectedPaymentMethod = nil
            showSdkFullView = false
        }

        /// Merchant-side OTT handler. Presents the OTT modal and suspends until the
        /// operator taps "Continue" (treated as "payment created — proceed"); the SDK
        /// then polls status. Cancelling resumes throwing so the SDK ends the flow.
        func createPayment(token: SdkPayments.TransactionController.OneTimeToken) async throws {
            guard let tokenString = token["token"] as? String else {
                throw MerchantPaymentError.missingToken
            }
            ott = tokenString
            presentOtt = true
            continuePayment = false

            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                ottContinuation = continuation
            }
        }

        /// Delivered by Render flows. Base (Lite/Full) never receives this — the SDK
        /// presents its own views. Render subclasses override to embed the view.
        func showView(
            view: AnyView?,
            process: SdkPayments.TransactionProcess,
            step: SdkPayments.TransactionViewStep
        ) {
            SdkPayments.defaultShowView(view: view, process: process, step: step)
        }

        func showLoading(isLoading: Bool) {
            // Base (Lite/Full) keeps the SDK's built-in loader. Render subclasses override
            // this to drive their own embedded loader instead.
            SdkPayments.defaultShowLoading(isLoading: isLoading)
        }
    }
}

extension TransactionView.ViewModel: SdkPayments.TransactionController {}

extension TransactionView.ViewModel: SdkPayments.PaymentListController {

    func onPaymentSelected(paymentSelected: SdkPayments.PaymentMethodSelected) {
        selectedPaymentMethod = paymentSelected
    }

    func onHeightChange(newHeight: CGFloat) {
        paymentViewHeight = newHeight
    }

    func onUnenroll(success: Bool) {
    }
}
