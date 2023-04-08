//
//  NetworkService.swift
//  SpeedRead
//
//  Created by Dias Manap on 04.02.2023.
//

import Foundation
import Combine
import Logging

    
class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URLRequest)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[💩] Bad response from URL: \(url)"
            case .unknown: return "[🤔] Unknown error occured"
            }
        }
    }

    static func download(url urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, urlRequest: urlRequest) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, urlRequest: URLRequest) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.badURLResponse(url: urlRequest)
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            print(response.statusCode)
            print(response.description)
            print(response.allHeaderFields)
            throw NetworkingError.badURLResponse(url: urlRequest)
        }
        return output.data
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw NetworkingError.badURLResponse(url: URLRequest(url: url))
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: URLRequest(url: url))
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error)
        }
    }
}


/*
TASK LIST:
   - Network Layer Using Combine
   - Navigation Layer
   - Design System + UI elements
 
   - Articles Page
   - Tests (almost done)
 
   - Started working on epub/fb2/pdf parsers
   - File Storage/Caching Layer
 
 TODO:
   - Finish Tests
   - Cache + formats reading -> Finish reading
*/
