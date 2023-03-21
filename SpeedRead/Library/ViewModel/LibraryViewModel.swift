//
//  LibraryViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 16.11.2022.
//

import Foundation
import Combine

struct LibraryResponse: Codable {
    let total: Int?
    let books: [Reading]?
}

final class LibraryViewModel: ObservableObject {
    @Published var readings = [Reading.example] // change
    var librarySubsription: AnyCancellable?
    var readingFetchSubsciption: AnyCancellable?
    
    func fetchLibrary() async {
        let request = LibraryRequest.fetchLibrary.url
        librarySubsription = NetworkingManager.download(url: request)
            .decode(
                type: LibraryResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (libraryResponse) in
                    if let readings = libraryResponse.books {
                        self?.readings = readings
                        self?.cacheReadings()
                    }
                    self?.librarySubsription?.cancel()
                }
            )
    }
    
    func cacheReadings() {
        for reading in readings {
            guard
                let link = reading.url,
                let url = URL(string: link)
            else {
                return
            }
            
            readingFetchSubsciption = NetworkingManager.download(url: url)
                .tryMap({ data in
                    return String(data: data, encoding: .utf8) ?? "error fetching text"
                })
                .sink(
                    receiveCompletion: NetworkingManager.handleCompletion,
                    receiveValue: { text in
                        let words = text.components(separatedBy: .whitespaces)
                        let wordsPerPage = 200
                        
                        var pages: [Int: [String]] = [:]
                        let maxPages = words.count / wordsPerPage

                        for i in 0...maxPages-1 {
                            let start = i * wordsPerPage
                            let end = (i+1) * wordsPerPage
                            pages[i] = Array(words[start...end])
                        }
                        
                        let start = maxPages * wordsPerPage
                        pages[maxPages] = Array(words[start...])
                        
                        try? pages.saveToDisk(
                            on: .cachesDirectory,
                            withName: "\(reading.id).txt"
                        )
                        
                        print("Caching \(reading.title) is finished")
                    }
                )
        }
    }
}
