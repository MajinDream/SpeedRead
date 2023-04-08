//
//  LibraryRequest.swift
//  SpeedRead
//
//  Created by Dias Manap on 05.03.2023.
//

import Foundation

enum LibraryRequest: BaseRequestable {
    case fetchLibrary
    case addBook(NewBook)

    var method: HTTPMethod {
        switch self {
        case .fetchLibrary: return .get
        case .addBook: return .post
        }
    }

    var path: String {
        switch self {
        case .fetchLibrary: return "books/list"
        case .addBook: return "books/add"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .addBook(newBook): return [
            "author": newBook.author,
            "title": newBook.title
        ]
        default: return [:]
        }
    }
}


struct UploadFileRequest: BaseRequestable {
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "books/add"
    }
    
    var author: String
    var title: String
    
    var fileData: Data
    var fileName: String
    var imageFileData: Data?
    var imageFileName: String?
    
    var parameters: Parameters {
        return ["author": author, "totalPages": "", "title": title]
    }
    
    var mimeType: String {
        let fileExtension = (fileName as NSString).pathExtension.lowercased()
        switch fileExtension {
        case "txt":
            return "text/plain"
        case "pdf":
            return "application/pdf"
        case "epub":
            return "application/epub+zip"
        default:
            return "application/octet-stream"
        }
    }
    
    var body: Data? {
        return fileData
    }
    
    func createMultipartBody() -> Data {
        var body = Data()
        
        // Add parameters
        for (key, value) in parameters {
            body.append("--\(Self.boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Add image file data
        if let imageData = imageFileData, let imageFileName = imageFileName {
            body.append("--\(Self.boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"imageUrl\"; filename=\"\(imageFileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Add file data
        body.append("--\(Self.boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"bookUrl\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        
        body.append("--\(Self.boundary)--\r\n".data(using: .utf8)!)
        
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
                request.setValue("multipart/form-data; boundary=\(Self.boundary)", forHTTPHeaderField: "Content-Type")
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
}
