//
//  TransactionViewModel.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import UIKit
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
        
        @Published var selectedPaymentMehtod: PaymentMethodSelected?
        var selectedPaymentMehtodLite: PaymentMethodSelected {
            TransactionPaymentSelected(paymentType: paymentType, vaultedToken: vaultedToken)
        }
        
        @Published var configLanguage: String = "EN"
        
        @Published var configCountryCode: String = "CO"
        
        var language: String? {
            configLanguage
        }
        
        var countryCode: String {
            configCountryCode
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
            Yuno.startCheckout(with: self)
            showSdkFullView = true
        }
        
        private func continuePaymentAction() {
            Yuno.continuePayment(showPaymentStatus: true)
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
    
    func yunoPaymentResult(_ result: YunoSDK.Yuno.Result) {
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
        case .userCancell:
            print(">>>>>>> yunoPaymentResult UserCancell")
        }
    }
    
    func yunoCreatePayment(with token: String, information: [String: Any]) {
        ott = token
        presentOtt = true
        continuePayment = false
    }
}

extension TransactionView.ViewModel: YunoEnrollmentDelegate {
    
    func yunoEnrollmentResult(_ result: YunoSDK.Yuno.Result) {
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
        case .userCancell:
            print(">>>>>>> yunoEnrollmentResult UserCancell")
        }
    }
}

extension TransactionView.ViewModel: YunoPaymentFullDelegate {
    func yunoDidUnenrollSuccessfully(_ success: Bool) {
        
    }
    
    func yunoDidSelect(paymentMethod: YunoSDK.PaymentMethodSelected) {
        selectedPaymentMehtod = paymentMethod
    }
    
    func yunoDidSelect(enrollmentMethod: YunoSDK.EnrollmentMethodSelected) {
        
    }
    
    func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat) {
        paymentViewHeight = height
    }
    
    func yunoUpdateEnrollmentMethodsViewHeight(_ height: CGFloat) {
        
    }
}

