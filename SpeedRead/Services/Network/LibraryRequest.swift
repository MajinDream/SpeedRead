//
//  LibraryRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 05.03.2023.
//

import Foundation

enum LibraryRequest: BaseRequestable {
    case fetchLibrary

    var method: HTTPMethod {
        switch self {
        case .fetchLibrary: return .get
        }
    }

    var path: String {
        switch self {
        case .fetchLibrary: return "books/list"
        }
    }

    var parameters: Parameters {
        switch self {
        default: return [:]
        }
    }
}
