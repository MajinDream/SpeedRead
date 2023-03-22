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
        TabView(selection: $selectedTab) {
            ForEach(MainTabs.allCases) { tab in
                NavigationStack(path: $navigationViewModel.path) {
                    tab.tabView
                        .navigationTitle(tab.name)
                        .navigationDestination(for: Route.self) { route in
                            route.destinationView
                        }

                }
                .tag(tab)
                .tabItem { tab.tabItem }
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

