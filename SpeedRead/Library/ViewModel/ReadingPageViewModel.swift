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
        defaults.set(page, forKey: "PageFor\(readingId)")
        defaults.set(position, forKey: "PositionFor\(readingId)")
    }
    
    func getCurrentPosition(readingId: String) -> (Int, Int) {
        return (
            defaults.integer(forKey: "PageFor\(readingId)"),
            defaults.integer(forKey: "PositionFor\(readingId)")
        )
    }
}
