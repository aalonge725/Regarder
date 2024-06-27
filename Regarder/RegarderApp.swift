//
//  RegarderApp.swift
//  Regarder
//
//  Created by Abraham Alonge on 5/27/24.
//

import SwiftUI
import Firebase

@main
struct RegarderApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
