//
//  RegisterRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 25.03.2023.
//

import Foundation

enum RegisterRequest: BaseRequestable {
    case register(username: String, nickname: String, password: String)

    var method: HTTPMethod {
        switch self {
        case .register: return .post
        }
    }

    var path: String {
        switch self {
        case .register: return "auth/signup"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .register(username, nickname, password): return [
            "email": username,
            "name": nickname,
            "password": password
        ]
        default: return [:]
        }
    }
}

struct RegisterResponse: Codable {
    let data: String?
}
