//
//  HomeViewController.swift
//  YunoSDK_Example
//
//  Created by Lautaro Pinto on 12/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var selectedTestType: ViewController.TestType = .payment
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startEnrollment(_ sender: Any) {
        selectedTestType = .enrollment
        performSegue(withIdentifier: "goToPay", sender: self)
    }
    
    @IBAction func startPaymentLite(_ sender: Any) {
        selectedTestType = .paymentLite
        performSegue(withIdentifier: "goToPay", sender: self)
    }
    
    
    @IBAction func startPaymentFull(_ sender: Any) {
        selectedTestType = .payment
        performSegue(withIdentifier: "goToPay", sender: self)
    }
    
    
    @IBAction func startDynamicSDK(_ sender: Any) {
        performSegue(withIdentifier: "goToPay", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "goToPay", let vc = segue.destination as? ViewController {
            vc.type = selectedTestType
        }
    }
}
