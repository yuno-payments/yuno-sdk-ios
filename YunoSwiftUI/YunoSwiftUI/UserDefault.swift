//
//  UserDefault.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
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

