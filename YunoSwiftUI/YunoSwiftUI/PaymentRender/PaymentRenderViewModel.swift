//
//  PaymentRenderViewModel.swift
//  YunoSwiftUI
//

import Foundation
import SdkPayments
import SwiftUI
import Combine

extension PaymentRenderView {

    final class ViewModel: TransactionView.ViewModel {

        let continueSubject = PassthroughSubject<Void, Never>()

        /// SDK-delivered form view (pushed via `showView`) and its submit handle.
        @Published var embeddedView: AnyView?
        private var process: SdkPayments.TransactionProcess?

        init(_ viewModel: TransactionView.ViewModel) {
            super.init(apiKey: viewModel.apiKey)
            checkoutSession = viewModel.checkoutSession
            customerSession = viewModel.customerSession
            customer = viewModel.customer
            paymentType = viewModel.paymentType
            vaultedToken = viewModel.vaultedToken
            configLanguage = viewModel.configLanguage
            configCountryCode = viewModel.configCountryCode
        }

        /// Starts the render payment flow. The SDK pushes the form through `showView`.
        func start() {
            // Wire the OTT "Continue" bridge (the base VM sets this up in
            // `loadConfiguration`, which render does not call — the SDK is already
            // initialized by the parent transaction screen).
            $continuePayment
                .removeDuplicates()
                .filter { $0 }
                .sink { [weak self] (_: Bool) in
                    self?.resumeOttApproval()
                }
                .store(in: &anyCancellables)

            let config = SdkPayments.TransactionConfig(
                checkoutSession: checkoutSession,
                countryCode: countryCode,
                language: language,
                controller: self,
                showStatusScreen: false
            )
            let transaction = SdkPayments.Transaction(config: config)
            self.transaction = transaction
            transaction.start(paymentSelected: selectedPaymentMethodLite)
        }

        /// Called by the merchant's own "Pay" button.
        func submitForm() {
            process?.onSubmit()
        }

        override func showView(
            view: AnyView?,
            process: SdkPayments.TransactionProcess,
            step: SdkPayments.TransactionViewStep
        ) {
            self.process = process
            self.embeddedView = view
        }

        override func showLoading(isLoading: Bool) {
            renderIsLoading = isLoading
        }

        override func onStatus(status: SdkPayments.TransactionStatus) {
            super.onStatus(status: status)
            embeddedView = nil
            renderIsLoading = false
            showSdkPaymentRenderView = false
        }
    }
}
