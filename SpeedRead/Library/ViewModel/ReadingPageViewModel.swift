//
//  ReadingPageViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 20.03.2023.
//

import Foundation
import Combine

final class ReadingPageViewModel: ObservableObject {
    func saveCurrentPosition(page: Int, position: Int, readingId: String) {
        UserDefaults.standard.set(page, forKey: "PageFor\(readingId)")
        UserDefaults.standard.set(position, forKey: "PositionFor\(readingId)")
    }
    
    func getCurrentPosition(readingId: String) -> (Int, Int) {
        return (
            UserDefaults.standard.integer(forKey: "PageFor\(readingId)"),
            UserDefaults.standard.integer(forKey: "PositionFor\(readingId)")
        )
    }
}
