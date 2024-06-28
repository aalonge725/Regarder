//
//  FirebaseManager.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/26/24.
//

import Foundation
import Firebase

class FirebaseManager: ObservableObject {
    @Published var userIsLoggedIn = false
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error registering user: \(error.localizedDescription)")
            }
        }
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error logging user in: \(error.localizedDescription)")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            userIsLoggedIn = false
        } catch {
            print("Error logging user out: \(error.localizedDescription)")
        }
    }
}
