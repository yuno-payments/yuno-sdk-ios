//
//  UserDefault.swift
//  YunoSDK_Example
//
//  Created by Jonathan Pacheco on 14/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

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
