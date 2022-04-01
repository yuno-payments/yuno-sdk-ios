//
//  AppDelegate.swift
//  YunoSDK
//
//  Created by Jonathan Pacheco on 04/01/2022.
//  Copyright (c) 2022 Jonathan Pacheco. All rights reserved.
//

import UIKit
import YunoSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Yuno.initialize(apiKey: "<Your Api Key>", for: "<Your App Id>")
        return true
    }
}
