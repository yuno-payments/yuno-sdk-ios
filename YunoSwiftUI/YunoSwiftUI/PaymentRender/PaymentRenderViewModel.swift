//
//  PaymentRenderViewModel.swift
//  YunoSwiftUI
//

import Foundation
import YunoSDK
import Combine

extension PaymentRenderView {

    final class ViewModel: TransactionView.ViewModel {

        let continueSubject = PassthroughSubject<Void, Never>()

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

        override nonisolated func yunoCreatePayment(with token: String, information: [String: Any]) {
            Task { @MainActor in
                renderIsLoading = true
                ott = token
                presentOtt = true
                continuePayment = false
            }
        }
    }
}
