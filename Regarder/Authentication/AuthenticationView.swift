//
//  AuthenticationView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/25/24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
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
                    firebaseManager.register(email: vm.email, password: vm.password)
                } label: {
                    Text("Register")
                        .regarderAuthButtonStyle()
                }
                
                Text("- or -")
                    .foregroundStyle(.accent)
                
                Button {
                    firebaseManager.logIn(email: vm.email, password: vm.password)
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

#Preview {
    AuthenticationView()
}
