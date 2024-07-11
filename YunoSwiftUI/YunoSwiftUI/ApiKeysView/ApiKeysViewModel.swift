//
//  ApiKeysViewModel.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import Foundation
import YunoSDK
import Foundation
import Combine

extension ApiKeysView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published var newApiKey: String = ""
        private var anyCancellables: Set<AnyCancellable> = []
        
        init() {
            $newApiKey
                .dropFirst()
                .removeDuplicates()
                .sink { [weak self] (apiKey: String) in
                    self?.persistApiKeys(apiKey: apiKey)
                }
                .store(in: &anyCancellables)
        }
        
        private func persistApiKeys(apiKey: String) {
            let encoder = JSONEncoder()
            guard let encoded = try? encoder.encode(apiKey) else { return }
            UserDefaults.standard.set(encoded, forKey: "apiKey")
        }
        
        func loadApiKeys() {
            let decoder = JSONDecoder()
            guard let data = UserDefaults.standard.data(forKey: "apiKey"),
                  let decoded = try? decoder.decode(String.self, from: data) else { return }
            newApiKey = decoded
        }
    }
}

