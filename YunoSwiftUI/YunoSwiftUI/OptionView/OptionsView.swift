//
//  OptionsView.swift
//  YunoSwiftUI
//
//  Created by Viviana Amezquita on 11/07/24.
//

import SwiftUI


enum OptionType {
    
    case ott(token: String, completion: () async -> Void)
    
    var title: String {
        switch self {
        case .ott:
            return "One Time Token"
        }
    }
    
    var label: String {
        switch self {
        case .ott(let token, _):
            return token
        }
    }
    
    @ViewBuilder
    var primaryButtonLabel: some View {
        switch self {
        case .ott:
            Label("Copy Ott", systemImage: "doc.on.doc")
        }
    }
    
    @ViewBuilder
    var secondaryButtonLabel: some View {
        switch self {
        case .ott:
            Label("Continue", systemImage: "figure.walk.motion")
        }
    }
}

struct OptionsView: View {
    
    let type: OptionType
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showModal = false
                } label: {
                    Image(systemName: "xmark")
                }
            }
            Spacer()
            Text(type.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(type.label)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 32.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                switch type {
                case .ott(let ott, _):
                    UIPasteboard.general.string = ott
                }
            } label: {
                type.primaryButtonLabel
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8.0)
            Button {
                Task {
                    switch type {
                    case .ott(_, let completion):
                        await completion()
                    }
                }
                showModal = false
            } label: {
                type.secondaryButtonLabel
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.accentColor, lineWidth: 1.0)
            )
            Button {
                showModal = false
            } label: {
                Label("Cancelar", systemImage: "clear")
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.accentColor, lineWidth: 1.0)
            )
            Spacer()
        }
        .frame( maxHeight: .infinity)
        .padding()
        .background(Color.white)
    }
}

extension View {
    
    @ViewBuilder
    func optionsView(type: OptionType,
                     showModal: Binding<Bool>) -> some View {
        modifier(
            CustomPopUpViewModifier(
                popupView: OptionsView(
                    type: type,
                    showModal: showModal
                ),
                backgroundColor: .black.opacity(0.5),
                animation: .default,
                isPresented: showModal
            )
        )
    }
}

#Preview {
    NavigationView {
        OptionsView(
            type: .ott(token: "") {},
            showModal: .constant(false)
        )
    }
}
