//
//  PaymentRenderView.swift
//  YunoSwiftUI
//

import SwiftUI
import YunoSDK

struct PaymentRenderView: View {

    @StateObject var viewModel: PaymentRenderView.ViewModel
    @State private var paymentFlow: YunoPaymentRenderFlowProtocol?
    @State private var formView: AnyView?

    init(viewModel: TransactionView.ViewModel) {
        self._viewModel = StateObject(wrappedValue: PaymentRenderView.ViewModel(viewModel))
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Checkout")
                        .font(.title.bold())
                        .padding(.top, 16)

                    sectionShimmer(title: "Products", rows: 4, height: 24)
                    sectionShimmer(title: "Shipping address", rows: 2, height: 24)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text("Payment method - \(viewModel.paymentType) (SDK)")
                                .font(.headline)
                            if viewModel.renderIsLoading {
                                ProgressView()
                                    .scaleEffect(0.8)
                            }
                        }
                        if let formView {
                            formView
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 8.0)
                                .padding(.top, 24.0)
                        } else if !viewModel.renderIsLoading {
                            unavailableView(
                                title: "Payment form not available",
                                subtitle: "Please try again later"
                            )
                        }
                    }

                    sectionShimmer(title: "Order summary", rows: 3, height: 40)
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 16)

            Button {
                paymentFlow?.submitForm()
            } label: {
                Text("Merchant - Pay")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        .optionsView(
            type: .ott(token: viewModel.ott) {
                continuePayment()
            },
            showModal: $viewModel.presentOtt
        )
        .onReceive(viewModel.continueSubject) {
            continuePayment()
        }
        .onViewDidLoadAsync {
            let flow = await Yuno.startPaymentRenderFlow(
                paymentMethodSelected: viewModel.selectedPaymentMethodLite,
                with: viewModel
            )
            await MainActor.run { paymentFlow = flow }
            let view = await flow.formView(
                paymentMethodSelected: viewModel.selectedPaymentMethodLite,
                with: viewModel
            )
            await MainActor.run { formView = view }
        }
        .navigationTitle("Payment render")
        .navigationBarTitleDisplayMode(.large)
    }

    private func continuePayment() {
        Task { @MainActor in
            formView = await paymentFlow?.continuePayment()
        }
    }

    private func sectionShimmer(title: String, rows: Int, height: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline).padding(.bottom, 8)
            ForEach(0..<rows, id: \.self) { _ in
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: height)
                    .cornerRadius(8)
            }
        }
    }

    private func unavailableView(title: String, subtitle: String) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 24))
                .foregroundColor(.orange)
            Text(title).font(.headline).foregroundColor(.gray)
            Text(subtitle).font(.subheadline).foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
