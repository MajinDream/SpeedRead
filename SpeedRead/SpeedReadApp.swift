//
//  SpeedReadApp.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

@main
struct SpeedReadApp: App {
    @StateObject var navigationViewModel = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationViewModel)
        }
    }
}
