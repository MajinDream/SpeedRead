//
//  LibraryView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct LibraryTabView: View {
    @StateObject var libraryViewModel = LibraryViewModel()
    
    var body: some View {
        VStack {
            recentReadView
            readingListView
            //Spacer()
        }
        .background(Color.srBackground)
        .navigationTitle("Library")
        .navigationBarTitleDisplayMode(.large)
        .toolbar { addToolBarItem }
        .task {
            await libraryViewModel.cacheReadings()
            if libraryViewModel.readings.isEmpty {
                await libraryViewModel.fetchLibrary()
            }
        }
        .sheet(isPresented: $libraryViewModel.isShowingAddBook) {
            addBookView
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
    
    var addBookView: some View {
        
        
        VStack(spacing: 10) {
            Text("Add your book")
                .padding(.bottom, 12)
            Group {
                TextField("Title", text: $libraryViewModel.addedBook.title)
                TextField("Subtitle", text: $libraryViewModel.addedBook.subtitle)
                TextField("Author", text: $libraryViewModel.addedBook.author)
                TextField("Type", text: $libraryViewModel.addedBook.type)
                TextField("Cover URL", text: $libraryViewModel.addedBook.iconUrl)
                TextField("Book URL", text: $libraryViewModel.addedBook.url)
                Button("Add Book") {
                    print("Added New Book")
//                    libraryViewModel.addBook
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.srSecondary.opacity(0.2))
            }
        }
        .padding(16)
        .font(.system(size: 20, weight: .semibold))
        .presentationDetents([.fraction(0.7)])
    }

    var addToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                libraryViewModel.isShowingAddBook = true
            } label: {
                Image(systemName: "plus")
                .font(.system(size: 17, weight: .semibold))
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
