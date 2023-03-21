//
//  ContentView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @State private var selectedTab = MainTabs.library
    
    init() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
    }
    
    var body: some View {
        NavigationStack(path: $navigationViewModel.path) {
            TabView(selection: $selectedTab) {
                ExerciseTabView()
                    .tag(MainTabs.exercise)
                    .tabItem { MainTabs.exercise.tabItem }
                
                MeasureTabView()
                    .tag(MainTabs.test)
                    .tabItem { MainTabs.test.tabItem }
                
                LibraryTabView()
                    .tag(MainTabs.library)
                    .tabItem { MainTabs.library.tabItem }
                
                StatsTabView()
                    .tag(MainTabs.stats)
                    .tabItem { MainTabs.stats.tabItem }
                
                SettingsView()
                    .tag(MainTabs.settings)
                    .tabItem { MainTabs.settings.tabItem }
            }
            .navigationTitle(selectedTab.name)
            .navigationDestination(for: Route.self) { route in
                route.destinationView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationViewModel())
    }
}
