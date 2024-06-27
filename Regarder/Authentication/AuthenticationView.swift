//
//  AuthenticationView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/25/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var vm = AuthenticationViewModel()
    @State private var animationValue = false
    
    var body: some View {
        ZStack {
            Color.customLight
                .ignoresSafeArea()
            
            VStack {
                Group {
                    Image(systemName: "movieclapper")
                        .font(.system(size: 50))
                        .rotationEffect(.degrees(animationValue ? 360 : 0))
                        .animation(
                            .linear(duration: 3)
                                .repeatForever(autoreverses: false),
                            value: animationValue
                        )
                    
                    Text("Regarder")
                        .bold()
                        .font(.largeTitle)
                }
                .foregroundStyle(.accent)
                
                TextField("Enter email", text: $vm.email)
                    .regarderAuthTextFieldStyle()
                
                SecureField("Enter password", text: $vm.password)
                    .regarderAuthTextFieldStyle()
                
                Button {
                    // TODO: add register logic
                } label: {
                    Text("Register")
                        .regarderAuthButtonStyle()
                }
                
                Text("- or -")
                    .foregroundStyle(.accent)
                
                Button {
                    // TODO: add log in logic
                } label: {
                    Text("Log In")
                        .regarderAuthButtonStyle()
                }
            }
        }
        .onAppear {
            animationValue = true
        }
    }
}

extension View {
    func regarderAuthTextFieldStyle() -> some View {
        self
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
            .textInputAutocapitalization(.never)
    }
}

extension Text {
    func regarderAuthButtonStyle() -> some View {
        self
            .bold()
            .padding()
            .padding(.horizontal)
            .foregroundStyle(.white)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    AuthenticationView()
}
