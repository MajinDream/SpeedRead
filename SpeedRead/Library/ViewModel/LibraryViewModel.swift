//
//  LibraryViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 16.11.2022.
//

import Foundation
import Combine
import OrderedCollections

struct LibraryResponse: Codable {
    let total: Int?
    let books: [Reading]?
}

struct NewBook: Codable {
    var title: String = ""
    var subtitle: String = ""
    var author: String = ""
    var type: String = ""
    var iconUrl: String = ""
    var url: String = ""
}

final class LibraryViewModel: ObservableObject {
    @Published var readings = [Reading.example] // change
    
    @Published var isShowingAddBook = false
    @Published var addedBook = NewBook()
    
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
                        let clearedText = text
                            .replacingOccurrences(of: "(\r\n){3,}", with: "\r\n ", options: .regularExpression)
                            .replacingOccurrences(of: "\r\n", with: "\r\n ", options: .regularExpression)
                        var words = clearedText.components(separatedBy: .whitespaces)
                        words = words
                            .filter({($0.trimmingCharacters(in: CharacterSet.whitespaces)).count > 0})
                            
    
                        let wordsPerPage = 200
                        
                        var pages: OrderedDictionary<Int, [String]> = [:]
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
