//
//  MainTabs.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

enum MainTabs: String, Hashable {
    case exercise = "Exercise"
    case test = "Test"
    case library = "Library"
    case stats = "Stats"
    case settings = "Settings"
    
    var name: String { return rawValue }

    var tabIconName: String {
        switch self {
        case .exercise: return "brain.head.profile"
        case .test:     return "list.bullet.clipboard"
        case .library:  return "book"
        case .stats:    return "chart.xyaxis.line"
        case .settings: return "gearshape"
        }
    }

    var tabItem: Label<Text, Image> {
        Label(self.name, systemImage: self.tabIconName)
    }
}
