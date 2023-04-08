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
    @State private var nickname = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Create an account")
                    .font(.title)
                    .padding(.bottom, 12)
                Group {
                    TextField("Username", text: $username)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    TextField("Nickname", text: $nickname)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                    Button("Register") {
                        Task {
                            authViewModel.isLoading = true
                            await authViewModel.register(
                                username: username,
                                nickname: nickname,
                                password: password
                            )
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
            
            if authViewModel.isLoading {
                LoadingView()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
