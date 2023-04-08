//
//  TipsRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.03.2023.
//

import Foundation

enum TipsRequest: BaseRequestable {
    case fetchTips

    var method: HTTPMethod {
        switch self {
        case .fetchTips: return .get
        }
    }

    var path: String {
        switch self {
        case .fetchTips: return "articles/list"
        }
    }

    var parameters: Parameters {
        switch self {
        default: return [:]
        }
    }
}

struct TipsResponse: Codable {
    let total: Int?
    let articles: [Article]?
}
