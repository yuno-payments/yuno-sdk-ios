//
//  EnvirotmentViewController.swift
//  YunoSDK_Example
//
//  Created by Jonathan Pacheco on 27/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import YunoSDK

class EnvirotmentViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var apiKeyTextField: UITextField!
    
    @UserDefault(key: Key.apiKey.rawValue, defaultValue: "")
    var apiKey: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiKeyTextField.text = apiKey
        apiKeyTextField.rx.text
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .subscribe(with: self, onNext: { (self, apiKey: String) in
                self.apiKey = apiKey
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction private func goToPay() {
        Yuno.initialize(apiKey: apiKey)
        performSegue(withIdentifier: "goToPay", sender: self)
    }
}
