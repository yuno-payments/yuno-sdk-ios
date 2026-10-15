//
//  EnrollmentRenderViewModel.swift
//  YunoSwiftUI
//

import Foundation
import SdkPayments
import SwiftUI
import Combine

extension EnrollmentRenderView {

    final class ViewModel: TransactionView.ViewModel {

        let continueSubject = PassthroughSubject<Void, Never>()

        /// SDK-delivered enrollment form (pushed via `showView`) and its submit handle.
        @Published var embeddedView: AnyView?
        private var process: SdkPayments.TransactionProcess?

        init(_ viewModel: TransactionView.ViewModel) {
            super.init(apiKey: viewModel.apiKey)
            customerSession = viewModel.customerSession
            customer = viewModel.customer
            paymentType = viewModel.paymentType
            configLanguage = viewModel.configLanguage
            configCountryCode = viewModel.configCountryCode
        }

        /// Starts the render enrollment flow. The SDK pushes the form through `showView`.
        func start() {
            let config = SdkPayments.TransactionConfig(
                customerSession: customerSession,
                countryCode: countryCode,
                language: language,
                controller: self,
                showStatusScreen: false
            )
            let transaction = SdkPayments.Transaction(config: config)
            self.transaction = transaction
            transaction.start(
                paymentSelected: SdkPayments.PaymentMethodSelected(
                    paymentMethodType: paymentType
                )
            )
        }

        /// Called by the merchant's own "Enroll" button.
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
            showSdkEnrollmentRenderView = false
        }
    }
}
