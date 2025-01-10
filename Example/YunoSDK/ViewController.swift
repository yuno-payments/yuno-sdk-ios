//
//  ViewController.swift
//  YunoSDK
//
//  Created by Jonathan Pacheco on 03/27/2022.
//  Copyright (c) 2022 Jonathan Pacheco. All rights reserved.
//

import UIKit
import Combine
import YunoSDK
import Then

enum Key: String {
    case checkoutSession, customerSession, country, apiKey, language, paymentSelectedString, paymentToken
}

class PaymentMethod: PaymentMethodSelected {
    
    var vaultedToken: String?
    var paymentMethodType: String
    
    init(vaultedToken: String?, paymentMethodType: String) {
        self.vaultedToken = vaultedToken
        self.paymentMethodType = paymentMethodType
    }
}

class ViewController: UIViewController, YunoPaymentDelegate, YunoEnrollmentDelegate, YunoMethodsViewDelegate {
    
    enum TestType {
        case enrollment, payment, paymentLite
    }
    var type: TestType = .payment

    @IBOutlet private weak var paymentMethodsContainer: UIView!
    @IBOutlet private weak var paymentMethodsContainerHeight: NSLayoutConstraint!
    @IBOutlet private weak var isLiteSwitch: UISwitch!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    @IBOutlet private weak var checkoutSessionTextField: UITextField!
    @IBOutlet private weak var customerSessionTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var languageTextField: UITextField!
    @IBOutlet private weak var countryStackView: UIStackView!
    @IBOutlet private weak var languageStackView: UIStackView!
    
    //Payment Section
    @IBOutlet weak var checkoutStack: UIStackView!
    @IBOutlet weak var liteStack: UIStackView!
    @IBOutlet weak var paymentButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentSeparatorHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentSepBottom: NSLayoutConstraint!
    @IBOutlet weak var paymentButtBottom: NSLayoutConstraint!
    @IBOutlet weak var paymentContBottom: NSLayoutConstraint!
    
    //Enrollment section
    @IBOutlet weak var customerStack: UIStackView!
    @IBOutlet weak var customerSepHeight: NSLayoutConstraint!
    @IBOutlet weak var customerTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var customerButtonHeight: NSLayoutConstraint!
    
    // Payment Lite
    @IBOutlet weak var paymentTokenTextField: UITextField!
    @IBOutlet weak var paymentMethodSelectedTextField: UITextField!
    @IBOutlet weak var paymentTokenStackView: UIStackView!
    @IBOutlet weak var paymentMethodSelectedStackView: UIStackView!
    
    @UserDefault(key: Key.checkoutSession.rawValue, defaultValue: "")
    var checkoutSession: String
    @UserDefault(key: Key.customerSession.rawValue, defaultValue: "")
    var customerSession: String
    @UserDefault(key: Key.country.rawValue, defaultValue: "AR")
    var countryCode: String
    @UserDefault(key: Key.language.rawValue, defaultValue: "ES")
    var language: String?
    @UserDefault(key: Key.paymentToken.rawValue, defaultValue: "")
    var paymentToken: String
    @UserDefault(key: Key.paymentSelectedString.rawValue, defaultValue: "")
    var paymentSelectedString: String
    
    private var anyCancellables = Set<AnyCancellable>()
    var paymentSelected: PaymentMethodSelected?
    var enrollmentSelected: EnrollmentMethodSelected?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = .systemBackground
        
        if type == .enrollment {
            hidePaymentSection()
            customerSessionTextField.text = customerSession
            customerSessionTextField.textPublisher()
                .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .sink { [weak self] (customerSession: String) in
                    guard let self = self else { return }
                    self.customerSession = customerSession
                }
                .store(in: &anyCancellables)
        }
        if type == .payment || type == .paymentLite {
            hideEnrollmentSection()
            checkoutSessionTextField.text = checkoutSession
            checkoutSessionTextField.textPublisher()
                .compactMap { (string: String?) -> String? in
                    string?.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                .sink { [weak self] (checkoutSession: String) in
                    guard let self = self else { return }
                    self.checkoutSession = checkoutSession
                    Yuno.startCheckout(with: self)
                    if self.type == .payment {
                        self.generatePaymentViews()
                    }
                }
                .store(in: &anyCancellables)
            
            if type == .paymentLite {
                preparePaymentLiteUI()
            }
        }
        
        countryTextField.text = countryCode
        countryTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (countryCode: String) in
                guard let self = self else { return }
                self.countryCode = countryCode
                Yuno.startCheckout(with: self)
            }
            .store(in: &anyCancellables)
        languageTextField.text = language
        languageTextField.inputView = pickerView
        languageTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (language: String) in
                guard let self = self else { return }
                self.language = language
                Yuno.startCheckout(with: self)
            }
            .store(in: &anyCancellables)
        Yuno.startCheckout(with: self)
    }

    func generatePaymentViews() {
        let generator = Yuno.methodsView(delegate: self)
        
        generator.getPaymentMethodsView(checkoutSession: checkoutSession, viewType: .separated) { [weak self] (view: UIView) in
            guard let self = self else { return }
            self.paymentMethodsContainer.subviews.forEach { $0.removeFromSuperview() }
            self.paymentMethodsContainer.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.paymentMethodsContainer.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.paymentMethodsContainer.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.paymentMethodsContainer.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: self.paymentMethodsContainer.bottomAnchor)
            ])
        }
    }
    
    @IBAction func startPayment(sender: Any) {
        if type == .paymentLite {
            let paymentSelected = PaymentMethod(
                vaultedToken: paymentTokenTextField.text,
                paymentMethodType: paymentMethodSelectedTextField.text ?? ""
            )
            Yuno.startPaymentLite(paymentSelected: paymentSelected)
        } else {
            Yuno.startPayment()
        }
    }
    
    @IBAction func endEditing(sender: Any) {
        view.endEditing(true)
    }
    
    func yunoCreatePayment(with token: String, information: [String : Any]) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        let debugView = DebugView(token: token)
        window.addSubview(debugView)
        debugView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            debugView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            debugView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
            debugView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
        ])
        debugView.layoutIfNeeded()
        debugView.continuePublisher
            .sink {
                debugView.removeFromSuperview()
                Yuno.continuePayment()
            }
            .store(in: &self.anyCancellables)
    }
    
    @IBAction func startEnrollment(sender: Any) {
        Yuno.enrollPayment(with: self)
    }
    
    func yunoPaymentResult(_ result: Yuno.Result) {
        debugPrint("yunoPaymentResult \(result)")
    }
    
    func yunoEnrollmentResult(_ result: Yuno.Result) {
        debugPrint("yunoEnrollmentResult \(result)")
    }
    
    func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat) {
        paymentMethodsContainerHeight.constant = height
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    func yunoDidSelect(paymentMethod: PaymentMethodSelected) {
        debugPrint("yunoDidSelect(paymentMethod \(paymentMethod)")
        self.paymentSelected = paymentMethod
    }
    
    func yunoUpdateEnrollmentMethodsViewHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    func yunoDidSelect(enrollmentMethod: EnrollmentMethodSelected) {
        debugPrint("yunoDidSelect(paymentMethod \(enrollmentMethod)")
        self.enrollmentSelected = enrollmentMethod
    }
}

final class DebugView: UIView {
    
    let token: String
    private var anyCancellables = Set<AnyCancellable>()

    private let continueSubject = PassthroughSubject<Void, Never>()
    var continuePublisher: AnyPublisher<Void, Never> {
        continueSubject.eraseToAnyPublisher()
    }
    
    init(token: String) {
        self.token = token
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .secondarySystemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        let tokenLabel = UILabel().then {
            $0.text = token
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.lineBreakMode = .byCharWrapping
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
            $0.minimumScaleFactor = 0.5
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor, constant: 24.0),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            ])
        }
        let copyButton = UIButton().then {
            addSubview($0)
            $0.backgroundColor = UIColor.lightGray
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: tokenLabel.bottomAnchor, constant: 16.0),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
                $0.heightAnchor.constraint(equalToConstant: 44.0)
            ])
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4.0
            $0.setTitle("Copiar", for: .normal)
            $0.addTarget(self, action: #selector(copyCode), for: .touchUpInside)
        }
        UIButton().do {
            addSubview($0)
            $0.backgroundColor = .purple
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 16.0),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0),
                $0.heightAnchor.constraint(equalToConstant: 44.0)
            ])
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4.0
            $0.setTitle("Continuar", for: .normal)
            $0.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        }
    }
    
    @objc private func continueAction() {
        continueSubject.send(())
    }
    
    @objc private func copyCode() {
        UIPasteboard.general.string = token
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var languages: [String] { ["EN", "ES", "PT"] }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageTextField.text = languages[row]
        language = languages[row]
    }
}

extension ViewController {
    func hidePaymentSection() {
        checkoutStack.isHidden = true
        liteStack.isHidden = true
        paymentMethodsContainer.isHidden = true
        
        languageStackView.isHidden = true
        
        [paymentMethodsContainerHeight, paymentButtonHeight, paymentTitleHeight,
         paymentSeparatorHeight, paymentSepBottom, paymentButtBottom, paymentContBottom]
            .forEach({ $0?.constant = 0 })
    }
    
    func hideEnrollmentSection() {
        customerStack.isHidden = true
        [customerSepHeight, customerTitleHeight, customerButtonHeight]
            .forEach({ $0?.constant = 0 })
    }
    
    func preparePaymentLiteUI() {
        liteStack.isHidden = true
        paymentTitleHeight.constant = 0
        paymentTokenStackView.isHidden = false
        paymentMethodSelectedStackView.isHidden = false
        
        paymentTokenTextField.text = paymentToken
        paymentTokenTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (paymentToken: String) in
                guard let self = self else { return }
                self.paymentToken = paymentToken
            }
            .store(in: &anyCancellables)

        paymentMethodSelectedTextField.text = paymentSelectedString
        paymentMethodSelectedTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (paymentMethodString: String) in
                guard let self = self else { return }
                self.paymentSelectedString = paymentMethodString
            }
            .store(in: &anyCancellables)
    }
}
