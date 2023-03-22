//
//  SettingsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import UIKit

let defaults = Foundation.UserDefaults.standard
final class SettingsViewModel: ObservableObject {
    
    @Published var readingMode: ReadingMode = ReadingMode(rawValue: defaults.string(forKey: "readingMode") ?? "Highlight") ?? .highlight {
        didSet {
            defaults.set(readingMode.rawValue, forKey: "readingMode")
        }
    }
    
    @Published var selectedTheme: ThemeType = ThemeType(rawValue: defaults.string(forKey: "selectedTheme") ?? "darkGray") ?? .darkGray  {
        didSet {
            defaults.set(selectedTheme.rawValue, forKey: "selectedTheme")
        }
    }

    @Published var selectedFont: Fonts = Fonts(rawValue: defaults.string(forKey: "selectedFont") ?? "SF Pro Display") ?? .sfProDisplay  {
        didSet {
            defaults.set(selectedFont.rawValue, forKey: "selectedFont")
        }
    }
    
    @Published var speed = defaults.double(forKey: "speed") {
        didSet {
            defaults.set(speed, forKey: "speed")
        }
    }
    @Published var length = defaults.double(forKey: "length") {
        didSet {
            defaults.set(length, forKey: "length")
        }
    }
    
    @Published var constrast = defaults.double(forKey: "constrast") {
        didSet {
            defaults.set(constrast, forKey: "constrast")
        }
    }
    
    @Published var fontSize = defaults.double(forKey: "fontSize") {
        didSet {
            defaults.set(fontSize, forKey: "fontSize")
        }
    }
    
    @Published var isPresentingSettings = false
    @Published var selectedSheet = SelectedSettingsSheet.reading
}
