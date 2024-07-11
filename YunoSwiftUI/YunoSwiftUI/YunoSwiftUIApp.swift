//
//  YunoSwiftUIApp.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI

@main
struct YunoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ApiKeysView()
            }.accentColor(Color.black)
        }
    }
}
