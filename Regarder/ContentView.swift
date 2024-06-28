//
//  ContentView.swift
//  Regarder
//
//  Created by Abraham Alonge on 5/27/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var titlesViewModel = TitlesViewModel()
    @StateObject private var firebaseManager = FirebaseManager()
    
    var body: some View {
        if firebaseManager.userIsLoggedIn {
            content
        } else {
            AuthenticationView()
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            firebaseManager.userIsLoggedIn = true
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
            
            ToDoView()
                .tabItem {
                    Label("ToDo", systemImage: "list.and.film")
                }
            
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
