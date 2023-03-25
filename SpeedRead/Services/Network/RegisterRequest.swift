//
//  RegisterRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 25.03.2023.
//

import Foundation

enum RegisterRequest: BaseRequestable {
    case register(username: String, password: String)

    var method: HTTPMethod {
        switch self {
        case .register: return .post
        }
    }

    var path: String {
        switch self {
        case .register: return "auth/register"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .register(username, password): return ["username": username, "password": password]
        default: return [:]
        }
    }
}

struct RegisterResponse: Codable {
    let success: Bool?
    let message: String?
}
