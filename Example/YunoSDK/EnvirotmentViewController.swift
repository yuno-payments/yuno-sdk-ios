//
//  EnvirotmentViewController.swift
//  YunoSDK_Example
//
//  Created by Jonathan Pacheco on 27/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import YunoSDK
import Combine
import YunoAntifraudClearsale

class EnvirotmentViewController: UIViewController {
    
    private var anyCancellables = Set<AnyCancellable>()
    @IBOutlet private weak var apiKeyTextField: UITextField!
    
    @UserDefault(key: Key.apiKey.rawValue, defaultValue: "")
    var apiKey: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiKeyTextField.text = apiKey
        apiKeyTextField.textPublisher()
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (apiKey: String) in
                self?.apiKey = apiKey
            }
            .store(in: &anyCancellables)
    }
    
    @IBAction private func goToPay() {
        Yuno.setFraudProviders(with: [YunoAntifraudClearsale()])
        Yuno.initialize(apiKey: apiKey)
        performSegue(withIdentifier: "goToHome", sender: self)
    }
}
