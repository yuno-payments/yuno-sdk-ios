//
//  EnrollmentRenderView.swift
//  YunoSwiftUI
//

import SwiftUI
import YunoSDK

struct EnrollmentRenderView: View {

    @StateObject var viewModel: EnrollmentRenderView.ViewModel
    @State private var enrollmentFlow: YunoEnrollmentRenderFlowProtocol?
    @State private var formView: AnyView?

    init(viewModel: TransactionView.ViewModel) {
        self._viewModel = StateObject(wrappedValue: EnrollmentRenderView.ViewModel(viewModel))
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Your Methods")
                        .font(.title.bold())
                        .padding(.top, 16)
                    cardsShimmers
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text("Enrollment method - \(viewModel.paymentType) (SDK)")
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
                            VStack {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.system(size: 24))
                                    .foregroundColor(.orange)
                                Text("Enrollment form not available")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Text("Please try again later")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    cardsShimmers
                    cardsShimmers
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 16)

            if enrollmentFlow?.needSubmit ?? false {
                Button {
                    enrollmentFlow?.submitForm()
                } label: {
                    Text("Merchant - Enroll")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                }
                .padding()
            }
        }
        .onViewDidLoad {
            let flow = Yuno.startEnrollmentRender(with: viewModel)
            enrollmentFlow = flow
            Task {
                let view = await flow.formView(with: viewModel)
                await MainActor.run { formView = view }
            }
        }
        .navigationTitle("Enrollment render")
        .navigationBarTitleDisplayMode(.large)
    }

    var cardsShimmers: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cards")
                .font(.headline)
                .padding(.bottom, 8)
            ForEach(0..<3, id: \.self) { _ in
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 24)
                    .cornerRadius(8)
            }
        }
    }
}
