//
//  LibraryViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 16.11.2022.
//

import Foundation

struct LibraryResponse: Codable {
    let total: Int?
    let books: [Reading]?
}

final class LibraryViewModel: ObservableObject {
    @Published var readings = [Reading]()
    
    func fetchLibrary() async {
        guard let url = URL(string: "http://13.115.20.106/api/books/list") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Data Here!")
            if let decodedResponse = try? JSONDecoder().decode(LibraryResponse.self, from: data) {
                readings = decodedResponse.books ?? []
                print("Done!")
            } else {
                print("Woops!")
            }
        } catch {
            print("Invalid data")
        }
    }
}
