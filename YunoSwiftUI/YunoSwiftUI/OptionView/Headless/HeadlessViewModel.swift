//
//  HeadlessViewModel.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import UIKit
import YunoSDK

extension HeadlessView {

    @MainActor
    final class ViewModel: ObservableObject {

        private var ott: String = ""
        @Published var headlessUrl: String = ""
        @Published var json: String = ""
        @Published var isButtonEnabled: Bool = true

        @Published var showOttView: Bool = false
        @Published var showUrlView: Bool = false
        @Published var showWebView: Bool = false

        var type: HeadlessType = .payment
        var paymentHeadless: YunoPaymentHeadless?
        var enrollHeadless: YunoEnrollHeadless?
        var optionType: OptionType = .ott(token: "", completion: {})

        /// Executes the headless flow based on the current type (payment or enrollment)
        func executeHeadless() {
            if let paymentHeadless = paymentHeadless {
                executePaymentHeadless(paymentHeadless)
            } else if let enrollHeadless = enrollHeadless {
                executeEnrollHeadless(enrollHeadless)
            }
        }

        /// Executes payment headless flow
        /// - Parameter paymentHeadless: The payment headless instance to use
        private func executePaymentHeadless(_ paymentHeadless: YunoPaymentHeadless) {
            Task { [weak self] in
                guard let self else { return }
                do {
                    let data = try TokenCollectedData(from: self.json)
                    self.isButtonEnabled = false
                    let result = try await paymentHeadless.generateToken(
                        data: data
                    )
                    self.isButtonEnabled = true
                    let token = result["token"] as? String ?? ""
                    self.ott = token
                    showOttView = true
                    optionType = .ott(token: ott, completion: { [weak self] in
                        guard let response = try? await paymentHeadless.getThreeDSecureChallenge() else {
                            logger.error("Error on getThreeDSecureChallenge")
                            return
                        }
                        self?.showUrlView = true
                        self?.headlessUrl = response.url
                        self?.optionType = .headless(url: response.url) {
                            self?.showWebView = true
                        }
                    })
                    logger.info("Token generated successfully. Result: \(result)")
                } catch {
                    self.isButtonEnabled = true
                    logger.error("Error executing payment headless: \(error.localizedDescription)")
                }
            }
        }

        /// Executes enrollment headless flow
        /// - Parameter enrollHeadless: The enrollment headless instance to use
        private func executeEnrollHeadless(_ enrollHeadless: YunoEnrollHeadless) {
            Task { [weak self] in
                guard let self else { return }
                do {
                    let data = try EnrollmentCollectedData(from: json)
                    self.isButtonEnabled = false
                    let result = try await enrollHeadless.continueEnrollment(
                        data: data
                    )
                    self.isButtonEnabled = true
                    logger.info("Enrollment completed successfully. Result: \(result)")
                } catch {
                    self.isButtonEnabled = true
                    logger.error("Error executing enrollment headless: \(error.localizedDescription)")
                }
            }
        }
    }
}
