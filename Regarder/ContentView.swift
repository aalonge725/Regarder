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
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            content
        } else {
            AuthenticationView()
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            userIsLoggedIn = true
                        }
                    }
                }
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
        }
    }
}

#Preview {
    ContentView()
}
