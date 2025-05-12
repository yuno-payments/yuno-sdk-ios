//
//  TransactionView.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI
import YunoSDK

struct TransactionView: View {
    
    @StateObject var viewModel: ViewModel
    @State private var isConfigurationPresented = false
    
    init(apiKey: String) {
        _viewModel = StateObject(wrappedValue: ViewModel(apiKey: apiKey))
    }
    
    var body: some View {
        content
            .optionsView(
                type: .ott(token: viewModel.ott) {
                    viewModel.continuePayment = true
                },
                showModal: $viewModel.presentOtt
            )
            .navigationTitle("Transaction")
            .navigationBarTitleDisplayMode(.large)
            .onViewDidLoad {
                Task {
                    await viewModel.loadConfiguration()
                }
            }
        
    }
    
    var content: some View {
        VStack {
            List {
                Section(header: Text("General")) {
                    HStack {
                        Label("Country", systemImage: "mappin.and.ellipse")
                            .foregroundColor(.black)
                        Spacer()
                        TextField("Code", text: $viewModel.configCountryCode)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .frame(width: 40.0)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                    HStack {
                        Label("Language", systemImage: "globe")
                            .foregroundColor(.black)
                        Spacer()
                        TextField("Code", text: $viewModel.configLanguage)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .frame(width: 40.0)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                }
                
                Section(header: Text("ENROLLMENT")) {
                    TextField("Customer Session", text: $viewModel.customerSession)
                        .frame(height: 54.0)
                    Button {
                        Yuno.enrollPayment(
                            with: viewModel,
                            showPaymentStatus: true
                        )
                    } label: {
                        HStack {
                            Label("Execute enrollment", systemImage: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .disabled(viewModel.customerSession.isEmpty)
                    .opacity(viewModel.customerSession.isEmpty ? 0.5 : 1.0)
                    
                }
                Section(header: Text("PAYMENT")) {
                    VStack {
                        TextField("Checkout Session", text: $viewModel.checkoutSession)
                            .frame(height: 54.0)
                        
                    }
                    TextField("Payment Type", text: $viewModel.paymentType)
                        .padding([.top, .bottom], 6.0)
                    TextField("Vaulted Token", text: $viewModel.vaultedToken)
                        .padding([.top, .bottom], 6.0)
                    Button {
                        Yuno.startCheckout(with: viewModel)
                        Yuno.startPaymentLite(
                            paymentSelected: viewModel.selectedPaymentMethodLite,
                            showPaymentStatus: true
                        )
                    } label: {
                        HStack {
                            Label("Execute payment LITE", systemImage: "dollarsign.square")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .disabled(viewModel.checkoutSession.isEmpty || viewModel.paymentType.isEmpty)
                    .opacity(viewModel.checkoutSession.isEmpty || viewModel.paymentType.isEmpty ? 0.5 : 1.0)
                    Button {
                        viewModel.loadMethodsView()
                    } label: {
                        HStack {
                            Label("Execute payment FULL", systemImage: "list.bullet.rectangle")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .disabled(viewModel.checkoutSession.isEmpty)
                    .opacity(viewModel.checkoutSession.isEmpty ? 0.5 : 1.0)
                    
                }
            }
            Group {
                NavigationLink(
                    destination: LazyView(PaymentFullView().environmentObject(viewModel)),
                    isActive: $viewModel.showSdkFullView,
                    label: { EmptyView() }
                )
            }
            
            
        }
    }
}

#Preview {
    NavigationView {
        TransactionView(apiKey: "")
    }
}


struct CustomPopUpViewModifier<PopupView: View>: ViewModifier {
    
    let popupView: PopupView
    let backgroundColor: Color
    let animation: Animation?
    
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .animation(nil, value: isPresented)
            .overlay(isPresented ? backgroundColor.edgesIgnoringSafeArea(.top) : nil)
            .overlay(isPresented ? popupView : nil)
            .animation(animation, value: isPresented)
    }
}
