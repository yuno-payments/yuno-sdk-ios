//
//  Textfield+extension.swift
//  YunoSDK_Example
//
//  Created by Viviana Amezquita on 14/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Combine

extension UITextField {
    /// This method is used to create a publisher that emits the text of the text field every time it changes.
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}
