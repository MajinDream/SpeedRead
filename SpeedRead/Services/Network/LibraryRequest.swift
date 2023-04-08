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
            "title": newBook.title,
            "image": newBook.iconUrl,
            "book": newBook.url
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
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Add image file data
        if let imageData = imageFileData, let imageFileName = imageFileName {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(imageFileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Add file data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"book\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}
