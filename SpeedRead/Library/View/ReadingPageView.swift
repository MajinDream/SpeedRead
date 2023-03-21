//
//  ReadingPageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 07.11.2022.
//

import SwiftUI
import Combine

struct ReadingPageView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var readingPageViewModel = ReadingPageViewModel()
    
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    let reading: Reading
    let readingPages: [Int: [String]]?
    @State var words: [String] = [""]
    @State var currentPage = 0
    @State var currentPosition = 0
    
    @State var isStop = true
    
    init(reading: Reading) {
        self.reading = reading
        self.readingPages = [Int: [String]].load(on: .cachesDirectory, fromFileName: "\(reading.id).txt")
        self.timer = Timer.publish(every: 1000, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        VStack {
            if settingsViewModel.readingMode == .highlight {
                highlightingView
            } else {
                singleWordView
            }            
        }
        .background(settingsViewModel.selectedTheme.backgroundColor)
        .navigationTitle(reading.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onTapGesture { pauseTimer() }
        .onAppear {
            let (page, position) = self.readingPageViewModel.getCurrentPosition(readingId: reading.id)
            self.currentPage = page
            self.currentPosition = position
            self.words = Array(readingPages?[currentPage] ?? [])
            stopTimer()
        }
        .toolbar {
            backToolBarItem
            settingsToolBarItem
        }
        .sheet(isPresented: $settingsViewModel.isPresentingSettings) {
            settingsSheetSelector
        }
    }
    
    
}

extension ReadingPageView {
    var highlightingView: some View {
        ScrollView(showsIndicators: false) {
            Text(words[...(currentPosition-1)].joined(separator: " "))
                .foregroundColor(settingsViewModel.selectedTheme.textColor.opacity(1 - (settingsViewModel.constrast / 100)))
            +
            Text(" \(words[currentPosition]) ")
                .foregroundColor(settingsViewModel.selectedTheme.textColor)
            +
            Text(words[(currentPosition+1)...].joined(separator: " "))
                .foregroundColor(settingsViewModel.selectedTheme.textColor.opacity(1 - (settingsViewModel.constrast / 100)))
        }
        .font(.system(size: settingsViewModel.fontSize, weight: .regular))
        .lineSpacing(5)
        .multilineTextAlignment(.leading)
        .onReceive(timer) { _ in
            showNextWord()
        }
        .padding(.horizontal, 25)
        .padding(.top, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var singleWordView: some View {
        Text(words[currentPosition])
            .font(.system(size: settingsViewModel.fontSize, weight: .regular))
            .foregroundColor(settingsViewModel.selectedTheme.textColor)
            .onReceive(timer) { _ in
                showNextWord()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var backToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                navigationViewModel.goBack()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
            }

        }
    }
    
    var settingsToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                settingsViewModel.isPresentingSettings = true
                stopTimer()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 17, weight: .semibold))
            }
        }
    }

    var settingsSheetSelector: some View {
        ZStack {
            settingsViewModel.selectedTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            switch settingsViewModel.selectedSheet {
            case .reading:
                SettingsSheetView()
                    .environmentObject(settingsViewModel)
                    .presentationDetents([.fraction(0.8)])
            case .font:
                FontsSheetView()
                    .environmentObject(settingsViewModel)
                    .presentationDetents([.fraction(0.8)])
            }
        }
        .foregroundColor(settingsViewModel.selectedTheme.textColor)
    }
}


// MARK: Logic
extension ReadingPageView {
    func pauseTimer() {
        if isStop {
            updateTimer()
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
        isStop = true
    }
    
    func updateTimer() {
        timer = Timer.publish(
            every: 60 / settingsViewModel.speed,
            on: .main,
            in: .common
        ).autoconnect()
        isStop = false
    }
    
    func showNextWord() {
        if (currentPosition + 1) == words.count {
            currentPage += 1
            words = readingPages?[currentPage] ?? ["Error"]
            currentPosition = 0
        } else {
            currentPosition += 1
        }
        
        readingPageViewModel.saveCurrentPosition(
            page: currentPage,
            position: currentPosition,
            readingId: reading.id
        )
    }
}

struct ReadingPageView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingPageView(reading: Reading.example)
    }
}
