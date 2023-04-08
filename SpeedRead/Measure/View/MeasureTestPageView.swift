//
//  MeasureTestPageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import SwiftUI
import Combine

struct MeasureTestPageView: View {
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @EnvironmentObject private var settingsViewModel: SettingsViewModel
    @ObservedObject var measureTestViewModel: MeasureTestViewModel
    
    @State private var currentPosition = 0
    @State var isStop = true
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(test: MeasureTest) {
        self.measureTestViewModel = MeasureTestViewModel(test: test)
        self.timer = Timer.publish(every: 1000, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                timerView
                    .padding(.bottom)
                
                readingTypePickerView
                getReadingView(type: measureTestViewModel.readingType)
                    .padding(.bottom)
                doneButton
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(settingsViewModel.selectedTheme.backgroundColor)
        .navigationTitle(measureTestViewModel.test.title)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            settingsToolBarItem
        }
        .sheet(isPresented: $settingsViewModel.isPresentingSettings) {
            settingsSheetSelector
        }
    }
}

extension MeasureTestPageView {
    enum MeasureReadingType: String {
        case regular
        case highlight
        case scroll
    }
    
    @ViewBuilder
    func getReadingView(type: MeasureReadingType) -> some View {
        switch type {
        case .regular:
            Text(.init(measureTestViewModel.test.content ?? ""))
                .font(
                    settingsViewModel.selectedFont == .sfProDisplay
                    ? .system(size: settingsViewModel.fontSize, weight: .regular)
                    : .custom(settingsViewModel.selectedFont.name, size: settingsViewModel.fontSize)
                )
                .foregroundColor(settingsViewModel.selectedTheme.textColor)
                .padding(.horizontal, 25)
                .padding(.top, 10)
        case .highlight:
            ScrollView(showsIndicators: false) {
                Text(measureTestViewModel.words[...(currentPosition-1)].joined(separator: " "))
                    .foregroundColor(settingsViewModel.selectedTheme.textColor.opacity(1 - (settingsViewModel.constrast / 100)))
                +
                Text(" \(measureTestViewModel.words[currentPosition]) ")
                    .foregroundColor(settingsViewModel.selectedTheme.textColor)
                +
                Text(measureTestViewModel.words[(currentPosition+1)...].joined(separator: " "))
                    .foregroundColor(settingsViewModel.selectedTheme.textColor.opacity(1 - (settingsViewModel.constrast / 100)))
            }
            .font(
                settingsViewModel.selectedFont == .sfProDisplay
                ? .system(size: settingsViewModel.fontSize, weight: .regular)
                : .custom(settingsViewModel.selectedFont.name, size: settingsViewModel.fontSize)
            )
            .lineSpacing(5)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 25)
            .padding(.top, 10)
            .onReceive(timer) { _ in
                showNextWord()
            }
            .onTapGesture(count: 2) { goBack() }
            .onTapGesture { pauseTimer() }
            .onAppear { stopTimer() }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .scroll:
            Text(measureTestViewModel.words[currentPosition])
                .font(
                    settingsViewModel.selectedFont == .sfProDisplay
                    ? .system(size: settingsViewModel.fontSize, weight: .regular)
                    : .custom(settingsViewModel.selectedFont.name, size: settingsViewModel.fontSize)
                )
                .foregroundColor(settingsViewModel.selectedTheme.textColor)
                .onReceive(timer) { _ in
                    showNextWord()
                }
                .onTapGesture(count: 2) { goBack() }
                .onTapGesture { pauseTimer() }
                .onAppear { stopTimer() }
                .frame(height: 250)
        }
    }
    
    var timerView: some View {
        Text("\(measureTestViewModel.timeElapsed) sec")
            .onReceive(measureTestViewModel.timer) { firedDate in
                measureTestViewModel.timeElapsed = Int(firedDate.timeIntervalSince(measureTestViewModel.startDate))
            }
            .foregroundColor(.srPrimary)
    }
    
    var readingTypePickerView: some View {
        Picker("ReadingTypeSelector", selection: $measureTestViewModel.readingType) {
            Text("Regular").tag(MeasureReadingType.regular)
            Text("Highlight").tag(MeasureReadingType.highlight)
            Text("Scroll").tag(MeasureReadingType.scroll)
        }.onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "primary")
        }
        .pickerStyle(.segmented)
        .padding(16)
    }
    
    var doneButton: some View {
        NavigationLink(value: Route.question(measureTestViewModel)) {
            Capsule()
                .foregroundColor(.accentColor)
                .frame(width: 150, height: 50)
                .overlay {
                    Text("Done")
                        .foregroundColor(.primary)
                        .font(.system(size: 22).bold())
                }
        }
        .onTapGesture {
            measureTestViewModel.goToNextQuestion()
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
                SettingsView(isMeasure: true)
                    .environmentObject(settingsViewModel)
                    .presentationDetents([.fraction(0.7)])
            case .font:
                FontsSheetView()
                    .environmentObject(settingsViewModel)
                    .presentationDetents([.fraction(0.7)])
            }
        }
        .foregroundColor(settingsViewModel.selectedTheme.textColor)
    }
}

extension MeasureTestPageView {
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
            every: 60.0 / settingsViewModel.speed,
            on: .main,
            in: .common
        ).autoconnect()
        isStop = false
    }
    
    func showNextWord() {
        print(measureTestViewModel.words)
        if (currentPosition + 1) == measureTestViewModel.words.count {
            stopTimer()
            measureTestViewModel.goToNextQuestion()
        } else {
            currentPosition += 1
        }
    }
    
    func goBack() {
        if (currentPosition - 10) <= 0 {
            currentPosition = 0
        } else {
            currentPosition -= 10
        }
    }
}

struct MeasureTestPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MeasureTestPageView(test: MeasureTest.example)
        }
    }
}
