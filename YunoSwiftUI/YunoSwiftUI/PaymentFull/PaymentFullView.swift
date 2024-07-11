//
//  PaymentFullView.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI
import Combine
import UIKit
import YunoSDK

struct PaymentFullView: View {
    
    @EnvironmentObject var viewModel: TransactionView.ViewModel
    @StateObject var viewContainer = ViewContainer()
    
    var body: some View {
        Group {
            VStack {
                ScrollView(showsIndicators: false) {
                    UIViewRepresentedView(view: viewContainer.view)
                        .frame(height: viewModel.paymentViewHeight)
                }
                Button {
                    Yuno.startPayment(showPaymentStatus: true)
                } label: {
                    Label("Pay", systemImage: "dollarsign.square")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .padding([.top, .bottom])
                        .disabled(viewModel.selectedPaymentMehtod == nil)
                        .frame(maxWidth: .infinity)
                }
                .background(viewModel.selectedPaymentMehtod == nil ? Color.gray : Color.black)
                .cornerRadius(8.0)
            }
            .padding()
            .onDisappear {
                viewModel.presentOtt = false
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Merchant App")
        }
        .onAppear {
            viewContainer.subscribe(to: viewModel.methodsView, checkoutSession: viewModel.checkoutSession)
        }
        .optionsView(
            type: .ott(token: viewModel.ott) {
                viewModel.continuePayment = true
            },
            showModal: $viewModel.presentOtt
        )
    }
}

@MainActor
final class ViewContainer: ObservableObject {
    
    let view = UIView()
    weak var currentView: UIView?
    
    func subscribe(to methodsView: MethodsView, checkoutSession: String) {
        methodsView.getPaymentMethodsView(
            checkoutSession: checkoutSession,
            viewType: .separated
        ) { [weak self] (newView: UIView) in
            self?.addNewView(newView)
        }
    }
    
    private func addNewView(_ newView: UIView) {
        currentView?.removeFromSuperview()
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newView.topAnchor.constraint(equalTo: view.topAnchor),
            newView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        currentView = newView
    }
}

struct UIViewRepresentedView: UIViewRepresentable {
    
    unowned let view: UIView
    
    func makeUIView(context: Context) -> UIView {
        view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}


#Preview {
    PaymentFullView()
        .environmentObject(TransactionView.ViewModel( apiKey: ""))
}
