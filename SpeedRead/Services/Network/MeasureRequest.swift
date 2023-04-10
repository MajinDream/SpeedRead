//
//  MeasureRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.03.2023.
//

import Foundation

enum MeasureRequest: BaseRequestable {
    case sendResult(SendableMeasureResult)
    case fetchTests
    case fetchQuestions

    var method: HTTPMethod {
        switch self {
        case .sendResult: return .post
        case .fetchTests: return .get
        case .fetchQuestions: return .get
        }
    }

    var path: String {
        switch self {
        case .sendResult: return "stat/result"
        case .fetchTests: return "paragraph/list"
        case let .fetchQuestions: return "questions/list"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .sendResult(result): return [
            "speed": result.speed,
            "comp": result.comp,
            "day": result.day,
            "readingType": result.readingType,
        ]
        default: return [:]
        }
    }
}

struct MeasureResponse: Codable {
    let total: Int?
    let paragraphs: [MeasureTest]?
}

struct QuestionsResponse: Codable {
    let total: Int?
    let questions: [Question]?
}

struct ResultResponse: Codable {
    let data: String?
}
