//
//  TransactionViewModel.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import Combine
import YunoSDK
import SwiftUI

typealias CustomerData = (id: String?, merchantId: String?)

extension TransactionView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        private var anyCancellables: Set<AnyCancellable> = []
        @Published var presentOtt: Bool = false
        @Published var ott: String = ""
        let apiKey: String
        private var customer: Customer?
        @Published var continuePayment = false
        
        @Published var isShowHeadless: Bool = false
        @Published var paymentViewHeight: CGFloat = 0
        var paymentHeadless: YunoPaymentHeadless?
        var enrollHeadless: YunoEnrollHeadless?
        
        @Published var selectedPaymentMethod: PaymentMethodSelected?
        var selectedPaymentMethodLite: PaymentMethodSelected {
            TransactionPaymentSelected(paymentType: paymentType, vaultedToken: vaultedToken)
        }
        
        @Published var paymentListView: AnyView?
        @Published var hasLoadedPaymentMethods = false
        
        @Published var configLanguage: String = "EN"
        
        @Published var configCountryCode: String = "CO"
        
        nonisolated var language: String? {
               MainActor.assumeIsolated { configLanguage }
           }
        
        nonisolated var countryCode: String {
               MainActor.assumeIsolated { configCountryCode }
           }
        
        @Published var customerSession: String = ""
        @Published var checkoutSession: String = ""
        @Published var paymentType: String = ""
        @Published var vaultedToken: String = ""
        @Published var showSdkFullView: Bool = false

        init(apiKey: String) {
            self.apiKey = apiKey
        }
        
        var viewController: UIViewController? {
            UIApplication.shared.windows.first?.rootViewController
        }
        
        func loadConfiguration() async {
            $continuePayment
                .removeDuplicates()
                .filter { $0 }
                .sink { [weak self] (continuePayment: Bool) in
                    self?.continuePaymentAction()
                }
                .store(in: &anyCancellables)
            
            initializeYunoSDK()
        }
        
        func initializeYunoSDK() {
            Yuno.initialize(apiKey: apiKey)
        }
        
        func loadMethodsView() {
            Task {
                await refreshPaymentMethods()
            }
            showSdkFullView = true
        }
        
        func loadPaymentMethodsViewIfNeeded() async {
            guard !hasLoadedPaymentMethods else { return }
            hasLoadedPaymentMethods = true
            paymentListView = await AnyView(Yuno.getPaymentMethodViewAsync(delegate: self))
        }
        
        /// Refrescar payment methods manualmente forzando la recarga
        func refreshPaymentMethods() async {
            hasLoadedPaymentMethods = false
            paymentListView = nil
            await loadPaymentMethodsViewIfNeeded()
        }
        
        private func continuePaymentAction() {
            Yuno.continuePayment()
            continuePayment = false
            presentOtt = false
        }
    }
}

final class TransactionPaymentSelected: PaymentMethodSelected {
    
    let paymentMethodType: String
    let vaultedToken: String?
    
    init(paymentType: String, vaultedToken: String) {
        self.paymentMethodType = paymentType
        self.vaultedToken = vaultedToken.isEmpty ? nil : vaultedToken
    }
}

extension TransactionView.ViewModel: YunoPaymentDelegate {
    
    nonisolated func yunoPaymentResult(_ result: YunoSDK.Yuno.Result) {
        switch result {
        case .reject:
            print(">>>>>>> yunoPaymentResult Reject")
        case .succeeded:
            print(">>>>>>> yunoPaymentResult Succeeded")
        case .fail:
            print(">>>>>>> yunoPaymentResult Fail")
        case .processing:
            print(">>>>>>> yunoPaymentResult Processing")
        case .internalError:
            print(">>>>>>> yunoPaymentResult InternalError")
        case .userCancelled:
            print(">>>>>>> yunoPaymentResult UserCancell")
        @unknown default:
            print(">>>>>>> yunoPaymentResult @unknown")
        }
    }
    
    nonisolated func yunoCreatePayment(with token: String, information: [String: Any]) {
        Task { @MainActor in
            ott = token
            presentOtt = true
            continuePayment = false
        }
    }
}

extension TransactionView.ViewModel: YunoEnrollmentDelegate {
    
    nonisolated func yunoEnrollmentResult(_ result: YunoSDK.Yuno.Result) {
        switch result {
        case .reject:
            print(">>>>>>> yunoEnrollmentResult Reject")
        case .succeeded:
            print(">>>>>>> yunoEnrollmentResult Succeeded")
        case .fail:
            print(">>>>>>> yunoEnrollmentResult Fail")
        case .processing:
            print(">>>>>>> yunoEnrollmentResult Processing")
        case .internalError:
            print(">>>>>>> yunoEnrollmentResult InternalError")
        case .userCancelled:
            print(">>>>>>> yunoEnrollmentResult UserCancel")
        @unknown default:
            print(">>>>>>> yunoEnrollmentResult @unknown")
        }
        
    }
}

extension TransactionView.ViewModel: YunoPaymentFullDelegate {
    nonisolated func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat) {
        print("paymentViewHeight \(height)")
        Task { @MainActor in
            paymentViewHeight = height
        }
    }
    
    nonisolated func yunoDidUnenrollSuccessfully(_ success: Bool) {
        
    }
    
    nonisolated func yunoDidSelect(paymentMethod: YunoSDK.PaymentMethodSelected) {
        Task { @MainActor in
            selectedPaymentMethod = paymentMethod
        }
    }

}

