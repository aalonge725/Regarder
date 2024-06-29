//
//  AuthenticationExtensions.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/27/24.
//

import SwiftUI

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
