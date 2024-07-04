//
//  ContentView.swift
//  Regarder
//
//  Created by Abraham Alonge on 5/27/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var firebaseManager = FirebaseManager()
    @StateObject private var titlesViewModel = TitlesViewModel()
    
    var body: some View {
        if firebaseManager.userIsLoggedIn {
            content
        } else {
            AuthenticationView()
                .onAppear {
                    titlesViewModel.setFirebaseManager(firebaseManager: firebaseManager)
                    
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if let user = user {
                            firebaseManager.userIsLoggedIn = true
                            firebaseManager.userID = user.uid
                        }
                    }
                }
                .environmentObject(firebaseManager)
        }
    }
    
    var content: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "movieclapper")
                }
                .environmentObject(titlesViewModel)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .environmentObject(firebaseManager)
        }
    }
}

#Preview {
    ContentView()
}
