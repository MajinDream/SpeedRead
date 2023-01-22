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
    
    func getTabName() -> String {
        return rawValue
    }

    func getTabIconName() -> String {
        switch self {
        case .exercise:
            return "brain.head.profile"
        case .test:
            return "list.bullet.clipboard"
        case .library:
            return "book"
        case .stats:
            return "chart.xyaxis.line"
        case .settings:
            return "gearshape"
        }
    }

    func getTabItem() -> Label<Text, Image> {
        Label(self.getTabName(),
              systemImage: self.getTabIconName())
    }
}
