//
//  ApiKeysView.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI
import YunoSDK

struct ApiKeysView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var goToCheckout: Bool = false
    
    var body: some View {
        VStack (spacing: 24.0) {
            Spacer()
            Image("yuno_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 60.0)
                .padding(.vertical, 30)
            Spacer()
            Text("Public API Key")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .center)
            TextField("Public API Key", text: $viewModel.newApiKey)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.gray.opacity(0.5))
                )
                .autocapitalization(.none)
                .autocorrectionDisabled()
            Button {
                if !viewModel.newApiKey.isEmpty {
                    goToCheckout = true
                }
            } label: {
                Text("Continue")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
            }            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.black, lineWidth: 1.0)
                )
                .padding(.bottom, 10.0)
            
            NavigationLink(
                destination: LazyView(TransactionView(apiKey: viewModel.newApiKey)),
                isActive: $goToCheckout,
                label: { EmptyView() }
            )
            Text("Made by iOS team with 💜")
            
        }.padding(.horizontal, 28.0)
            .padding(.vertical, 10.0)
            .onAppear {
                viewModel.loadApiKeys()
            }
    }
}

#Preview {
    ApiKeysView()
}


struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
