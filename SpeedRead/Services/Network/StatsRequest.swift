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
        case .fetchStats: return "stats/list"
        }
    }

    var parameters: Parameters {
        switch self {
        default: return [:]
        }
    }
}
