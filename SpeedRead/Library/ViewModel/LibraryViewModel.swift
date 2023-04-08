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
    @Published var readings = [Reading]()
    
    @Published var isShowingAddBook = false
    @Published var addedBook = NewBook()
    
    @Published var isLoading = true
    
    var librarySubsription: AnyCancellable?
    var addBookSubsription: AnyCancellable?
    var readingFetchSubscription: AnyCancellable?
    
    func fetchLibrary() async {
        let request = LibraryRequest.fetchLibrary.urlRequest
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
    
    func addBook() async {
        var requestMain: BaseRequestable? = nil
        if let fileURL = Bundle.main.url(forResource: "example", withExtension: "txt"),
           let imageURL = Bundle.main.url(forResource: "image", withExtension: "jpg") {
            do {
                let fileData = try Data(contentsOf: fileURL)
                let fileName = fileURL.lastPathComponent
                let imageFileData = try Data(contentsOf: imageURL)
                let imageFileName = imageURL.lastPathComponent
                
                requestMain = UploadFileRequest(
                    author: "Author Name",
                    title: "Book Title",
                    fileData: fileData,
                    fileName: fileName,
                    imageFileData: imageFileData,
                    imageFileName: imageFileName
                )
                
            } catch {
                print("Error reading file data: \(error)")
            }
        }
        
        guard let requestMain else { return }
        let request = requestMain.urlRequest
        print("DEBUG: \(request.description)")
        print("DEBUG: \(request.allHTTPHeaderFields)")
        print("DEBUG: \(request.httpBody?.description)")
        
        librarySubsription = NetworkingManager.download(url: request)
            .decode(
                type: BaseResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (baseResponse) in
                    print(baseResponse)
                    if baseResponse.error == true {
                        print("DEBUG: Add Book ERROR")
                    } else {
                        print("DEBUG: Add Book SUCCESS")
                    }
                    self?.addBookSubsription?.cancel()
                }
            )
    }
    
    func cacheReadings() {
        for reading in readings {
            print("DEBUG: Caching \(reading.title) has started")
            guard
                let link = reading.url,
                let url = URL(string: link)
            else {
                print("DEBUG: URL ERROR \(reading.title)")
                continue
            }
            
            readingFetchSubscription = NetworkingManager.download(url: url)
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

                        if maxPages > 1 {
                            for i in 0...maxPages-1 {
                                let start = i * wordsPerPage
                                let end = (i+1) * wordsPerPage
                                pages[i] = Array(words[start...end])
                            }
                        }
                        
                        let start = maxPages * wordsPerPage
                        pages[maxPages] = Array(words[start...])
                        
                        try? pages.saveToDisk(
                            on: .cachesDirectory,
                            withName: "\(reading.id).txt"
                        )
                        
                        self.isLoading = false
                        
                        print("DEBUG: Caching \(reading.title) is finished")
                    }
                )
        }
    }
}
