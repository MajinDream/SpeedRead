//
//  RegisterView.swift
//  SpeedRead
//
//  Created by Dias Manap on 25.03.2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Create an account")
                .font(.title)
                .padding(.bottom, 12)
            Group {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                Button("Register") {
                    Task {
                        await authViewModel.register(username: username, password: password)
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.srSecondary.opacity(0.2))
            }
        }
        .padding(16)
        .font(.system(size: 20, weight: .semibold))
        .presentationDetents([.fraction(0.7)])
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
