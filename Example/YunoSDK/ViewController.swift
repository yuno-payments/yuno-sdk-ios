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

class ViewController: UIViewController, YunoPaymentDelegate, YunoEnrollmentDelegate, YunoMethodsViewDelegate {
    
    @IBOutlet private weak var paymentMethodsContainer: UIView!
    @IBOutlet private weak var paymentMethodsContainerHeight: NSLayoutConstraint!
    @IBOutlet private weak var enrollmentMethodsContainer: UIView!
    @IBOutlet private weak var enrollmentMethodsContainerHeight: NSLayoutConstraint!
    @IBOutlet private weak var isLiteSwitch: UISwitch!
    
    @IBOutlet private weak var checkoutSessionTextField: UITextField!
    @IBOutlet private weak var customerSessionTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    
    @UserDefault(key: .checkoutSession, defaultValue: "")
    var checkoutSession: String
    @UserDefault(key: .customerSession, defaultValue: "")
    var customerSession: String
    @UserDefault(key: .country, defaultValue: "")
    var countryCode: String
    private let disposeBag = DisposeBag()
    
    var paymentSelected: PaymentMethodSelected?
    var enrollmentSelected: EnrollmentMethodSelected?
    var isLite: Bool { isLiteSwitch.isOn }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationController?.view.backgroundColor = .systemBackground
        } else {
            navigationController?.view.backgroundColor = .white
        }
        let generator = Yuno.methodsView()
        generator.delegate = self
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
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(_checkoutSession)
            .disposed(by: disposeBag)
        
        customerSessionTextField.text = customerSession
        customerSessionTextField.rx.text
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(_customerSession)
            .disposed(by: disposeBag)
        
        countryTextField.text = countryCode
        countryTextField.rx.text
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(_countryCode)
            .disposed(by: disposeBag)
    }
    
    @IBAction func startPayment(sender: Any) {
        Yuno.startPayment(with: self) { (token: String, completion: @escaping () -> Void) in
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            debugPrint(token)
            let debugView = DebugView(token: token)
            window.addSubview(debugView)
            debugView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                debugView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                debugView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24.0)
            ])
            
            debugView.layoutIfNeeded()
            
            debugView.continueObservable
                .subscribe(onNext: {
                    debugView.removeFromSuperview()
                    completion()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    @IBAction func startEnrollment(sender: Any) {
        Yuno.addNewPaymentMethod(with: self) { (token: String, completion: @escaping () -> Void) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion()
            }
        }
    }
    
    func yunoPaymentResultSuccess() {
        debugPrint("yunoPaymentResultSuccess")
    }
    
    func yunoPaymentResultError() {
        debugPrint("yunoPaymentResultError")
    }
    
    func yunoPaymentResultCanceled() {
        debugPrint("yunoPaymentResultCanceled")
    }
    
    func yunoEnrollmentResultSuccess() {
        debugPrint("yunoEnrollmentResultSuccess")
    }
    
    func yunoEnrollmentResultError() {
        debugPrint("yunoEnrollmentResultError")
    }
    
    func yunoEnrollmentResultCanceled() {
        debugPrint("yunoEnrollmentResultCanceled")
    }
    
    func yunoUpdatePaymentMethodsViewHeight(_ height: CGFloat) {
        paymentMethodsContainerHeight.constant = height
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    func yunoUpdateEnrollmentMethodsViewHeight(_ height: CGFloat) {
        enrollmentMethodsContainerHeight.constant = height
        UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
        }
    }
    
    func yunoDidSelect(paymentMethod: PaymentMethodSelected) {
        debugPrint("yunoDidSelect(paymentMethod \(paymentMethod)")
        self.paymentSelected = paymentMethod
    }
    
    func yunoDidSelect(enrollmentMethod: EnrollmentMethodSelected) {
        debugPrint("yunoDidSelect(paymentMethod \(enrollmentMethod)")
        self.enrollmentSelected = enrollmentMethod
    }
}

@propertyWrapper
final class UserDefault<Value>: ObserverType {
    
    enum Key: String {
        case checkoutSession, customerSession, country, apiKey
    }
    
    let key: Key
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    init(key: Key, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: Value {
        get {
            return container.object(forKey: key.rawValue) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key.rawValue)
        }
    }
    
    func on(_ event: Event<Value>) {
        if case Event<Value>.next(let value) = event {
            wrappedValue = value
        }
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
            backgroundColor = .lightGray
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
        copyButton.backgroundColor = .gray
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
            .subscribe(onNext: {
                UIPasteboard.general.string = self.token
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
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 4.0
        continueButton.setTitle("Continuar", for: .normal)
        continueButton.rx.tap
            .throttle(.microseconds(400), latest: false, scheduler: MainScheduler.instance)
            .subscribe(continueSubject)
            .disposed(by: disposeBag)
    }
}
