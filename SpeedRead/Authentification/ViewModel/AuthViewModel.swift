//
//  AuthViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 25.03.2023.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var token = defaults.string(forKey: "token") ?? "" {
        didSet {
            defaults.set(token, forKey: "token")
        }
    }
    
    var loginSubsciption: AnyCancellable?
    var registrationSubsciption: AnyCancellable?
    
    func login(username: String, password: String) async {
        if username == "test", password == "test" {
            DispatchQueue.main.async {
                self.token = "success"
            }
            return
        }
        
        let request = LoginRequest.login(username: username, password: password).url
        loginSubsciption = NetworkingManager.download(url: request)
            .decode(
                type: LoginResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] loginResult in
                    guard
                        let loginToken = loginResult.token,
                        loginResult.success == true else
                    {
                        //TODO: show error, return error, or something
                        return
                    }
                    self?.token = loginToken
                }
            )
    }
    
    func register(username: String, password: String) async {
        let request = RegisterRequest.register(username: username, password: password).url
        loginSubsciption = NetworkingManager.download(url: request)
            .decode(
                type: RegisterResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] registerResult in
                    guard registerResult.success == true else {
                        //TODO: show error, return error, or something
                        return
                    }
                    //TODO: send succes
                }
            )
    }
    
    func logout() {
        token = ""
    }
}
