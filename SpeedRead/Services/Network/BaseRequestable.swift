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
    var body: Data? { get }
    var boundary: String { get }
    var urlRequest: URLRequest { get }
}


extension BaseRequestable {
    var baseURL: String {
        return Constants.baseURL.rawValue
    }
    
    var boundary: String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    func createMultipartBody() -> Data {
        var body = Data()
        
        // Add parameters
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Add file data
        if let fileData = self.body {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"file\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
            body.append(fileData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    var urlRequest: URLRequest {
        let fullPath = baseURL + "/" + "\(path)"
        
        var urlComponents = URLComponents(string: fullPath)
        if method == .get && !parameters.isEmpty {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue

        if method != .get && !parameters.isEmpty {
            if method == .post && body != nil {
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = createMultipartBody()
            } else {
                if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) {
                    request.httpBody = jsonData
                    let decoded = try? JSONSerialization.jsonObject(with: jsonData, options: [])
                    if let dictFromJSON = decoded as? [String: Any] {
                        print(dictFromJSON)
                    }
                }
            }
        }
        return request
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "User-Agent": "iOS",
            "Authorization" : "Bearer \(defaults.string(forKey: "token") ?? "")"
        ]
    }
}

struct BaseResponse: Codable {
    let error: Bool?
    let message: String?
}
