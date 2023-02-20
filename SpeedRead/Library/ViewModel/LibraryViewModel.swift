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
    @Published var readings = [Reading]()
    var librarySubsription: AnyCancellable?
    
    func fetchLibrary() async {
        readings = [Reading.example]
        
        guard let url = URL(string: "http://13.115.20.106/api/books/list") else {
            print("Invalid URL")
            return
        }
        
        librarySubsription = NetworkingManager.download(url: url)
            .decode(type: LibraryResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue:
                    { [weak self] (libraryResponse) in
                if let readings = libraryResponse.books {
                    self?.readings = readings
                }
                self?.librarySubsription?.cancel()
            })
    }
    
}
