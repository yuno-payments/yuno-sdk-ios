//
//  EnrollmentRenderViewModel.swift
//  YunoSwiftUI
//

import Foundation
import YunoSDK
import Combine

extension EnrollmentRenderView {

    final class ViewModel: TransactionView.ViewModel {

        let continueSubject = PassthroughSubject<Void, Never>()

        init(_ viewModel: TransactionView.ViewModel) {
            super.init(apiKey: viewModel.apiKey)
            customerSession = viewModel.customerSession
            customer = viewModel.customer
            paymentType = viewModel.paymentType
            configLanguage = viewModel.configLanguage
            configCountryCode = viewModel.configCountryCode
        }
    }
}
