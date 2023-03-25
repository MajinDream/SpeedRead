//
//  MainTabs.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

enum MainTabs: String, Hashable, CaseIterable, Identifiable {
    var id: String { return rawValue }
    
    case exercise = "Training"
    case test = "Measuring"
    case library = "Library"
    case stats = "Statistics"
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
    
    @ViewBuilder
    var tabView: some View {
        switch self {
        case .exercise:     ExerciseTabView()
        case .test:         MeasureTabView()
        case .library:      LibraryTabView()
        case .stats:        StatsTabView()
        case .settings:     SettingsTabView()
        }
    }

    var tabItem: Label<Text, Image> {
        Label(self.name, systemImage: self.tabIconName)
    }
}
