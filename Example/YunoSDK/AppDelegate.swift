//
//  AppDelegate.swift
//  YunoSDK
//
//  Created by Jonathan Pacheco on 03/27/2022.
//  Copyright (c) 2022 Jonathan Pacheco. All rights reserved.
//

import UIKit
import YunoSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Here your scheme URL should be the same as the one you set in the customer session
        guard url.scheme == "yunoexample" else { return false }
        return Yuno.receiveDeeplink(url, showStatusView: true)
    }
}

