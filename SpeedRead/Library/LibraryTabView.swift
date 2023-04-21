//
//  LibraryView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI
import PhotosUI

struct LibraryTabView: View {
    @StateObject var libraryViewModel = LibraryViewModel()
    
    @State private var isRefreshing = false
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarData: Data?
    @State private var avatarImage: Image?
    @State private var isPickerShown = false
    @State private var fileurl: URL?
    @State private var fileData: Data?
    
    
    var body: some View {
        ZStack {
            VStack {
                recentReadView
                readingListView
                //Spacer()
            }
            .background(Color.srBackground)
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.large)
            .toolbar { addToolBarItem }
            .sheet(isPresented: $libraryViewModel.isShowingAddBook) {
                addBookView
            }
            
            if libraryViewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            if libraryViewModel.readings.isEmpty {
                await libraryViewModel.fetchLibrary()
            }
        }
        .refreshable {
            await libraryViewModel.fetchLibrary()
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
        ZStack {
            VStack(spacing: 10) {
                Text("Add your book")
                    .padding(.bottom, 12)
                Group {
                    TextField("Title", text: $libraryViewModel.addedBook.title)
                    TextField("Author", text: $libraryViewModel.addedBook.author)
                    TextField("Type", text: $libraryViewModel.addedBook.type)
                    
                    HStack {
                        PhotosPicker("Select Cover", selection: $avatarItem, matching: .images)
                        Spacer()
                        if let avatarImage {
                            avatarImage
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                        }
                    }
                    
                    HStack {
                        if let url = fileurl {
                            Text("\(url.lastPathComponent)")
                        } else {
                            Text("No file selected")
                        }
                        
                        Spacer()
                        
                        Button("Select File") {
                            isPickerShown = true
                        }
                    }
                    
                    Button("Add Book") {
                        Task {
                            libraryViewModel.addedBook.icon = self.avatarData ?? Data()
                            do {
                                guard let fileurl = fileurl else { return }
                                fileData = try Data(contentsOf: fileurl)
                            } catch {
                                print("Error reading file data: \(error)")
                            }
                            libraryViewModel.addedBook.book = self.fileData ?? Data()
                            libraryViewModel.addedBook.fileName = self.fileurl?.lastPathComponent ?? ""
                            await libraryViewModel.addBook()
                        }
                    }
                }
                .sheet(isPresented: $isPickerShown) {
                    DocumentPicker(isShown: $isPickerShown, url: $fileurl)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color.srSecondary.opacity(0.2))
                }
            }
            .onChange(of: avatarItem) { _ in
                Task {
                    if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                        avatarData = data
                        if let uiImage = UIImage(data: data) {
                            avatarImage = Image(uiImage: uiImage)
                            return
                        }
                    }
                    
                    print("DEBUG: Failed to pick photo")
                }
            }
            .padding(16)
            .font(.system(size: 20, weight: .semibold))
            .presentationDetents([.fraction(0.8)])
            
            if libraryViewModel.isLoading {
                LoadingView()
            }
        }
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
