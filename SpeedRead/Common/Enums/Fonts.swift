//
//  Fonts.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import Foundation

enum Fonts: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case sfProDisplay = "SF Pro Display"
    case avenir = "Avenir"
    case timesNewRoman = "TimesNewRoman"
    case openDyslexic = "OpenDyslexic"
    
    var name: String { self.rawValue }
}
