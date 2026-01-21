//
//  HeadlessView.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI
import YunoSDK

enum HeadlessType {
    case payment
    case enroll
}

struct HeadlessView: View {

    @StateObject private var viewModel: ViewModel

    init(paymentHeadless: YunoPaymentHeadless) {
        let vm = ViewModel()
        vm.paymentHeadless = paymentHeadless
        vm.type = .payment
        _viewModel = StateObject(wrappedValue: vm)
    }

    init(enrollHeadless: YunoEnrollHeadless) {
        let vm = ViewModel()
        vm.enrollHeadless = enrollHeadless
        vm.type = .enroll
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            TextEditor(text: $viewModel.json)
                .font(.system(size: 12.0, design: .monospaced))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                )
            Button {
                viewModel.executeHeadless()
            } label: {
                Label("Execute Headless", systemImage: "cursorarrow.square")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    .padding([.top, .bottom])
                    .frame(maxWidth: .infinity)
            }
            .disabled(!viewModel.isButtonEnabled)
            .background(viewModel.isButtonEnabled ? Color.black : Color.gray)
            .cornerRadius(8.0)
            .padding(.top, 24.0)
        }
        .optionsView(type: viewModel.optionType, showModal: $viewModel.showOttView)
        .optionsView(type: viewModel.optionType, showModal: $viewModel.showUrlView)
        .padding()
        .navigationTitle("Headless")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Paste") {
                    if let data = UIPasteboard.general.string {
                        viewModel.json = data
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showWebView) {
            if !viewModel.headlessUrl.isEmpty {
                HeadlessWebView(url: viewModel.headlessUrl)
            }
        }
    }
}

#Preview {
    NavigationView {
        HeadlessView(paymentHeadless: Yuno.apiClientPayment(
            countryCode: "CO",
            checkoutSession: ""
        ))
    }
}
