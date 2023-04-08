//
//  StatsRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.03.2023.
//

import Foundation

enum StatsRequest: BaseRequestable {
    case fetchStats

    var method: HTTPMethod {
        switch self {
        case .fetchStats: return .get
        }
    }

    var path: String {
        switch self {
        case .fetchStats: return "users/whoami"
        }
    }

    var parameters: Parameters {
        switch self {
        default: return [:]
        }
    }
}

struct StatsResponse: Codable {
    let data: UserInfo?
}

struct UserInfo: Codable {
    let user: UserData?
    let stat: [StatsModel]?
}

struct UserData: Codable {
    let id: String?
    let email: String?
    let name: String?
    let readingsProgress: [Int]?
}
