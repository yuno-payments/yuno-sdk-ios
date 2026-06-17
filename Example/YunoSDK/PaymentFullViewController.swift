//
//  PaymentFullViewController.swift
//  YunoSDK_Example
//
//  Copyright © 2026 CocoaPods. All rights reserved.
//

import UIKit
import Combine
import YunoSDK
import Then

/// Dedicated screen for the Full payment flow: embeds the SDK's payment
/// method list view and starts the payment with the selected method.
final class PaymentFullViewController: UIViewController, YunoPaymentFullDelegate {

    // MARK: - Session values (shared with the rest of the example app)

    @UserDefault(key: Key.checkoutSession.rawValue, defaultValue: "")
    var checkoutSession: String
    @UserDefault(key: Key.country.rawValue, defaultValue: "AR")
    var countryCode: String
    @UserDefault(key: Key.language.rawValue, defaultValue: "ES")
    var storedLanguage: String

    var language: String? { storedLanguage }

    var viewController: UIViewController? { self }

    // MARK: - State

    private var paymentSelected: PaymentMethodSelected?
    private var anyCancellables = Set<AnyCancellable>()

    // MARK: - Subviews

    private let checkoutSessionTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Checkout session"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.clearButtonMode = .whileEditing
    }

    private let scrollView = UIScrollView().then {
        $0.keyboardDismissMode = .interactive
        $0.showsVerticalScrollIndicator = false
    }

    private let paymentMethodsContainer = UIView()
    private var paymentMethodsContainerHeight: NSLayoutConstraint!

    private lazy var payButton = UIButton(type: .system).then {
        $0.setTitle("Pay", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8.0
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(startPayment), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment Full"
        view.backgroundColor = .systemBackground
        setupSubviews()

        checkoutSessionTextField.text = checkoutSession
        checkoutSessionTextField.textPublisher()
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] (checkoutSession: String) in
                guard let self = self else { return }
                self.checkoutSession = checkoutSession
                self.loadPaymentMethodsView()
            }
            .store(in: &anyCancellables)

        updatePayButton()
        if !checkoutSession.isEmpty {
            loadPaymentMethodsView()
        }
    }

    // MARK: - Payment methods list (Full)

    private func loadPaymentMethodsView() {
        guard !checkoutSession.isEmpty else { return }
        paymentSelected = nil
        updatePayButton()
        Task {
            let methodsView: UIView = await Yuno.getPaymentMethodViewAsync(delegate: self)
            self.paymentMethodsContainer.subviews.forEach { $0.removeFromSuperview() }
            self.paymentMethodsContainer.addSubview(methodsView)
            methodsView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                methodsView.topAnchor.constraint(equalTo: self.paymentMethodsContainer.topAnchor),
                methodsView.leadingAnchor.constraint(equalTo: self.paymentMethodsContainer.leadingAnchor),
                methodsView.trailingAnchor.constraint(equalTo: self.paymentMethodsContainer.trailingAnchor),
                methodsView.bottomAnchor.constraint(equalTo: self.paymentMethodsContainer.bottomAnchor)
            ])
        }
    }

    @objc private func startPayment() {
        view.endEditing(true)
        Yuno.startPayment()
    }

    private func updatePayButton() {
        let isEnabled = paymentSelected != nil
        payButton.isEnabled = isEnabled
        payButton.backgroundColor = isEnabled ? .black : .gray
    }

    // MARK: - YunoPaymentFullDelegate

    func yunoDidSelect(paymentMethod: PaymentMethodSelected) {
        debugPrint("yunoDidSelect(paymentMethod: \(paymentMethod))")
        paymentSelected = paymentMethod
        updatePayButton()
    }

    func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat) {
        paymentMethodsContainerHeight.constant = height
        print(">>>> \(height)")
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }

    func yunoDidUnenrollSuccessfully(_ success: Bool) {
        debugPrint("yunoDidUnenrollSuccessfully \(success)")
    }

    func yunoCreatePayment(with token: String, information: [String: Any]) {
        debugPrint("yunoCreatePayment(with: \(token), information: \(information))")
        let debugView = DebugView(token: token)
        view.addSubview(debugView)
        debugView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            debugView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            debugView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            debugView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        debugView.layoutIfNeeded()
        debugView.continuePublisher
            .sink {
                debugView.removeFromSuperview()
                Yuno.continuePayment()
            }
            .store(in: &anyCancellables)
    }

    func yunoPaymentResult(_ result: Yuno.Result) {
        debugPrint("yunoPaymentResult \(result)")
        let alert = UIAlertController(
            title: "Payment result",
            message: "\(result)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Layout

    private func setupSubviews() {
        let sessionLabel = UILabel().then {
            $0.text = "Checkout session"
            $0.font = .systemFont(ofSize: 17.0)
        }

        [sessionLabel, checkoutSessionTextField, scrollView, payButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        scrollView.addSubview(paymentMethodsContainer)
        paymentMethodsContainer.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodsContainerHeight = paymentMethodsContainer.heightAnchor.constraint(equalToConstant: 0.0)

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            sessionLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16.0),
            sessionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            sessionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),

            checkoutSessionTextField.topAnchor.constraint(equalTo: sessionLabel.bottomAnchor, constant: 8.0),
            checkoutSessionTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            checkoutSessionTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),

            scrollView.topAnchor.constraint(equalTo: checkoutSessionTextField.bottomAnchor, constant: 16.0),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),
            scrollView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -16.0),

            paymentMethodsContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            paymentMethodsContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            paymentMethodsContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            paymentMethodsContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            paymentMethodsContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            paymentMethodsContainerHeight,

            payButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            payButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),
            payButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16.0),
            payButton.heightAnchor.constraint(equalToConstant: 46.0)
        ])
    }
}
