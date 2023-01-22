//
//  LibraryView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct LibraryTabView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @StateObject var libraryViewModel = LibraryViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationViewModel.path){
            VStack {
                recentReadView
                readingListView
                //Spacer()
            }
            .navigationDestination(for: Reading.self) { reading in
                ReadingPageView(reading: reading)
            }
            .background(Color("background"))
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("WIP SORT")
                    } label: {
                        HStack {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                            Text("Sort")
                        }
                        .font(.system(size: 17, weight: .semibold))
                    }

                }
                 
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("WIP ADD")
                    } label: {
                        HStack {
                            Text("Add")
                            Image(systemName: "plus")
                        }
                        .font(.system(size: 17, weight: .semibold))
                    }
                }
            }
            .navigationDestination(for: Reading.self) { reading in
                ReadingPageView(reading: reading)
            }
            .task {
                if libraryViewModel.readings.isEmpty {
                    await libraryViewModel.fetchLibrary()
                }
            }
        }
    }
}

extension LibraryTabView {
    var recentReadView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recently Read")
                .font(.system(size: 14, weight: .semibold))
                .padding([.leading, .top], 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(libraryViewModel.readings) { reading in
                            RecentReadIconView(reading: reading)
                    }
                }
                .padding(.horizontal, 16)
            }
            .shadow(radius: 4, y: 4)
        }
        .padding(.bottom, 23)
    }
    
    var readingListView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Reading List")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 16)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(libraryViewModel.readings) { reading in
                        ReadingRowView(reading: reading)
                            .padding(.horizontal, 16)
                    }
                }
                .shadow(radius: 4, y: 4)
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabView()
            .environmentObject(NavigationViewModel())
    }
}
