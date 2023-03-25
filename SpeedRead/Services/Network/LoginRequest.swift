//
//  LoginRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 25.03.2023.
//

import Foundation

enum LoginRequest: BaseRequestable {
    case login(username: String, password: String)

    var method: HTTPMethod {
        switch self {
        case .login: return .get
        }
    }

    var path: String {
        switch self {
        case .login: return "auth/login"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .login(username, password): return ["username": username, "password": password]
        default: return [:]
        }
    }
}

struct LoginResponse: Codable {
    let token: String?
    let success: Bool?
    let message: String?
}

