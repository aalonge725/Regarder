//
//  SettingsView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/6/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        Button {
            firebaseManager.logOut()
        } label: {
            Text("Log Out")
                .regarderAuthButtonStyle()
        }
    }
}

#Preview {
    SettingsView()
}
