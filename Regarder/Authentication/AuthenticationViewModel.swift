//
//  AuthenticationViewModel.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/25/24.
//

import Foundation
import Firebase

class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}
