//
//  ViewController.swift
//  YunoSDK
//
//  Created by Jonathan Pacheco on 03/27/2022.
//  Copyright (c) 2022 Jonathan Pacheco. All rights reserved.
//

import UIKit
import RxSwift
import YunoSDK

enum Key: String {
    case checkoutSession, customerSession, country, apiKey, language
}

class ViewController: UIViewController, YunoPaymentDelegate, YunoEnrollmentDelegate, YunoMethodsViewDelegate {
    
    @IBOutlet private weak var paymentMethodsContainer: UIView!
    @IBOutlet private weak var paymentMethodsContainerHeight: NSLayoutConstraint!
    @IBOutlet private weak var enrollmentMethodsContainer: UIView!
    @IBOutlet private weak var enrollmentMethodsContainerHeight: NSLayoutConstraint!
    @IBOutlet private weak var isLiteSwitch: UISwitch!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    @IBOutlet private weak var checkoutSessionTextField: UITextField!
    @IBOutlet private weak var customerSessionTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var languageTextField: UITextField!
    
    @UserDefault(key: Key.checkoutSession.rawValue, defaultValue: "")
    var checkoutSession: String
    @UserDefault(key: Key.customerSession.rawValue, defaultValue: "")
    var customerSession: String
    @UserDefault(key: Key.country.rawValue, defaultValue: "")
    var countryCode: String
    @UserDefault(key: Key.language.rawValue, defaultValue: "es")
    var language: String
    
    private let disposeBag = DisposeBag()
    private var paymentSelected: PaymentMethodSelected?
    private var enrollmentSelected: EnrollmentMethodSelected?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationController?.view.backgroundColor = .systemBackground
        } else {
            navigationController?.view.backgroundColor = .white
        }
        
        let generator = Yuno.methodsView(delegate: self)
        generator.getPaymentMethodsView(checkoutSession: checkoutSession) { [weak self] (view: UIView) in
            guard let self = self else { return }
            self.paymentMethodsContainer.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.paymentMethodsContainer.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.paymentMethodsContainer.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.paymentMethodsContainer.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: self.paymentMethodsContainer.bottomAnchor)
            ])
        }
        generator.getEnrollmentMethodsView(customerSession: customerSession) { [weak self] (view: UIView) in
            guard let self = self else { return }
            self.enrollmentMethodsContainer.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.enrollmentMethodsContainer.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.enrollmentMethodsContainer.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.enrollmentMethodsContainer.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: self.enrollmentMethodsContainer.bottomAnchor)
            ])
        }
        
        checkoutSessionTextField.text = checkoutSession
        checkoutSessionTextField.rx.text
            .compactMap { (string: String?) -> String? in
                string?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .subscribe(with: self, onNext: { (self, checkoutSession: String) in
                self.checkoutSession = checkoutSession
                Yuno.startCheckout(with: self)
            })
            .disposed(by: disposeBag)
        
        customerSessionTextField.text = customerSession
        customerSessionTextField.rx.text
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(with: self, onNext: { (self, customerSession: String) in
                self.customerSession = customerSession
                Yuno.startCheckout(with: self)
            })
            .disposed(by: disposeBag)
        
        countryTextField.text = countryCode
        countryTextField.rx.text
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(with: self, onNext: { (self, countryCode: String) in
                self.countryCode = countryCode
                Yuno.startCheckout(with: self)
            })
            .disposed(by: disposeBag)
        languageTextField.text = language
        languageTextField.inputView = pickerView
        languageTextField.rx.text
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(with: self, onNext: { (self, language: String) in
                self.language = language
                Yuno.startCheckout(with: self)
            })
            .disposed(by: disposeBag)
        Yuno.startCheckout(with: self)
    }
    
    @IBAction func startPayment(sender: Any) {
        if isLiteSwitch.isOn, let paymentSelected = paymentSelected {
            Yuno.startPaymentLite(paymentSelected: paymentSelected)
        } else {
            Yuno.startPayment()
        }
    }
    
    @IBAction func endEditing(sender: Any) {
        view.endEditing(true)
    }
    
    func yunoCreatePayment(with token: String) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        debugPrint(token)
        let debugView = DebugView(token: token)
        window.addSubview(debugView)
        debugView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            debugView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            debugView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0)
        ])
        
        debugView.layoutIfNeeded()
        
        debugView.continueObservable
            .subscribe(onNext: {
                debugView.removeFromSuperview()
                Yuno.continuePayment()
            })
            .disposed(by: self.disposeBag)
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
        enrollmentMethodsContainerHeight.constant = height
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
    private let disposeBag = DisposeBag()
    private let continueSubject = PublishSubject<Void>()
    var continueObservable: Observable<Void> {
        continueSubject.asObservable()
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
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        } else {
            backgroundColor = .white
        }
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        let tokenLabel = UILabel()
        tokenLabel.text = token
        addSubview(tokenLabel)
        tokenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24.0),
            tokenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            tokenLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0)
        ])
        let copyButton = UIButton()
        addSubview(copyButton)
        copyButton.backgroundColor = .lightGray
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            copyButton.topAnchor.constraint(equalTo: tokenLabel.bottomAnchor, constant: 16.0),
            copyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            copyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            copyButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        copyButton.layer.masksToBounds = true
        copyButton.layer.cornerRadius = 4.0
        copyButton.setTitle("Copiar", for: .normal)
        copyButton.rx.tap
            .throttle(.microseconds(400), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                UIPasteboard.general.string = self?.token
            })
            .disposed(by: disposeBag)
        
        let continueButton = UIButton()
        addSubview(continueButton)
        continueButton.backgroundColor = .purple
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 16.0),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24.0),
            continueButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        continueButton.layer.masksToBounds = false
        continueButton.layer.cornerRadius = 4.0
        continueButton.setTitle("Continuar", for: .normal)
        continueButton.rx.tap
            .throttle(.microseconds(400), latest: false, scheduler: MainScheduler.instance)
            .subscribe(continueSubject)
            .disposed(by: disposeBag)
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

@propertyWrapper
struct UserDefault<Value> {
    
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
