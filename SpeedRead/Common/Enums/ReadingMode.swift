//
//  ReadingMode.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import Foundation

enum ReadingMode: String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }

    case highlight = "Highlight"
    case scroll = "Word-Scroll"
}
