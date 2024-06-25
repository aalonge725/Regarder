//
//  ContentView.swift
//  Regarder
//
//  Created by Abraham Alonge on 5/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var titlesViewModel = TitlesViewModel()
    
    var body: some View {
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
