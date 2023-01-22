//
//  ContentView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = MainTabs.library
    
    init() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExerciseView()
                .tag(MainTabs.exercise)
                .tabItem { MainTabs.exercise.getTabItem() }
            
            TestView()
                .tag(MainTabs.test)
                .tabItem { MainTabs.test.getTabItem() }
            
            LibraryView()
                .tag(MainTabs.library)
                .tabItem { MainTabs.library.getTabItem() }
            
            StatsView()
                .tag(MainTabs.stats)
                .tabItem { MainTabs.stats.getTabItem() }
            
            SettingsView()
                .tag(MainTabs.settings)
                .tabItem { MainTabs.settings.getTabItem() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
