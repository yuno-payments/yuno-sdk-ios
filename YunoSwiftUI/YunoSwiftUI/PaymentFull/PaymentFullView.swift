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
    
    var body: some View {
        Group {
            VStack {
                ScrollView(showsIndicators: false) {
                    Yuno.getPaymentMethodView(delegate: viewModel)
                }
                Button {
                    Yuno.startPayment(showPaymentStatus: true)
                } label: {
                    Label("Pay", systemImage: "dollarsign.square")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .padding([.top, .bottom])
                        .disabled(viewModel.selectedPaymentMethod == nil)
                        .frame(maxWidth: .infinity)
                }
                .background(viewModel.selectedPaymentMethod == nil ? Color.gray : Color.black)
                .cornerRadius(8.0)
            }
            .padding()
            .onDisappear {
                viewModel.presentOtt = false
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Merchant App")
        }

        .optionsView(
            type: .ott(token: viewModel.ott) {
                viewModel.continuePayment = true
            },
            showModal: $viewModel.presentOtt
        )
    }
}

#Preview {
    PaymentFullView()
        .environmentObject(TransactionView.ViewModel( apiKey: ""))
}
