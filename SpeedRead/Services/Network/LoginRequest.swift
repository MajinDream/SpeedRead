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
        case .login: return .post
        }
    }

    var path: String {
        switch self {
        case .login: return "auth/signin"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .login(username, password): return [
            "email": username,
            "password": password
        ]
        default: return [:]
        }
    }
}

struct LoginResponse: Codable {
    let data: String?
}

