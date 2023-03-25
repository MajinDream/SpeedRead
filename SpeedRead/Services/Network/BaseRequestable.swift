//
//  EndPoints.swift
//  SpeedRead
//
//  Created by Dias Manap on 05.03.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

protocol BaseRequestable {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var headers: HTTPHeaders { get }
    var urlRequest: URLRequest { get }
    var url: URL { get }
}

extension BaseRequestable {
    var baseURL: String {
        return Constants.baseURL.rawValue
    }
    
    var url: URL {
        let fullPath = baseURL + "/" + "\(path)"
        guard let url = URL(string: fullPath) else {
            return URL(string: "https://www.google.kz/")!
        }
        return url
    }
    
    var urlRequest: URLRequest {
        let fullPath = baseURL + "/" + "\(path)"
        
        var urlComponents = URLComponents(string: fullPath)
        if method == .get && !parameters.isEmpty {
            urlComponents?.queryItems = parameters.map { (key, value) in
                var valueAsString = ""
                if let value = value as? String {
                    valueAsString = value
                }
                if let value = value as? Int {
                    valueAsString = String(value)
                }
                if let value = value as? Double {
                    valueAsString = String(value)
                }
                if let value = value as? Bool {
                    if value {
                        valueAsString = "true"
                    } else {
                        valueAsString = "false"
                    }
                }
                return URLQueryItem(name: key, value: valueAsString)
            }
        }
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        if method != .get && !parameters.isEmpty {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) {
                request.httpBody = jsonData
                let decoded = try? JSONSerialization.jsonObject(with: jsonData, options: [])
                if let dictFromJSON = decoded as? [String: Any] {
                    print(dictFromJSON)
                }
            }
        }
        return request
    }
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "User-Agent": "iOS"
        ]
    }
}

struct BaseResponse: Codable {
    let code: Int?
    let message: String?
    let error: String?
}
