//
//  Dictionary+Extension.swift
//  SpeedRead
//
//  Created by Dias Manap on 16.03.2023.
//

import Foundation

extension Dictionary where Key: Codable, Value: Codable {
    static func load (
        on directory: FileManager.SearchPathDirectory,
        fromFileName fileName: String,
        using fileManager: FileManager = .default
    ) -> [Key: Value]? {
        let fileURL = Self.getDocumentsURL(
            on: directory,
            withName: fileName,
            using: fileManager
        )
        guard let data = fileManager.contents(atPath: fileURL.path) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode([Key: Value].self, from: data)
        } catch(let error) {
            print(error)
            return nil
        }
    }
    
    func saveToDisk(
        on directory: FileManager.SearchPathDirectory,
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let fileURL = Self.getDocumentsURL(
            on: directory,
            withName: name,
            using: fileManager
        )
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
    
    private static func getDocumentsURL(
        on directory: FileManager.SearchPathDirectory,
        withName name: String,
        using fileManager: FileManager
    ) -> URL {
        
        let folderURLs = fileManager.urls(for: directory, in: .userDomainMask)
        let fileURL = folderURLs[0].appendingPathComponent(name)
        return fileURL
    }
}
