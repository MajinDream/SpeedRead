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
    
    @Published var isLoading = false
    
    var loginSubsciption: AnyCancellable?
    var registrationSubsciption: AnyCancellable?
    
    func login(username: String, password: String) async {
        let request = LoginRequest.login(username: username, password: password).urlRequest
        loginSubsciption = NetworkingManager.download(url: request)
            .decode(
                type: LoginResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] loginResult in
                    guard let loginToken = loginResult.data else {
                        self?.loginSubsciption?.cancel()
                        return
                    }
                    self?.isLoading = false
                    self?.token = loginToken
                    self?.loginSubsciption?.cancel()
                }
            )
    }
    
    func register(username: String, nickname: String, password: String) async {
        let request = RegisterRequest.register(
            username: username,
            nickname: nickname,
            password: password
        ).urlRequest
 
        loginSubsciption = NetworkingManager.download(url: request)
            .decode(
                type: RegisterResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] registerResult in
                    guard let loginToken = registerResult.data else {
                        //TODO: show error, return error, or something
                        self?.registrationSubsciption?.cancel()
                        return
                    }
                    self?.isLoading = false
                    self?.token = loginToken
                    self?.registrationSubsciption?.cancel()
                    //TODO: send succes
                }
            )
    }
    
    func logout() {
        token = ""
    }
}
