//
//  SettingsSheetView.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import SwiftUI

enum SelectedSettingsSheet : String, Identifiable {
    var id: String { self.rawValue }
    
    case reading
    case font
}

struct SettingsSheetView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            readingModeView
            speedSliderView
//            lengthSliderView
            contrastSliderView
            themePickerView
            fontChooseView
        }
        .padding(.horizontal, 24)
    }
}

struct SettingsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheetView()
            .environmentObject(SettingsViewModel())
    }
}

extension SettingsSheetView {
    var readingModeView: some View {
        HStack {
            Text("Reading Mode")
                .font(.system(size: 22, weight: .medium))
            
            Spacer()
            
            Picker(selection: $settingsViewModel.readingMode, label: Text("Reading Mode")) {
                ForEach(ReadingMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "primary")
            }
        }
        .padding(.top, 10)
    }
    
    var speedSliderView: some View {
        SettingsSliderView(type: .speed, value: $settingsViewModel.speed)
    }
    
    var lengthSliderView: some View {
        SettingsSliderView(type: .length, value: $settingsViewModel.length)
    }
    
    var contrastSliderView: some View {
        SettingsSliderView(type: .contrast, value: $settingsViewModel.constrast)
    }
    
    var themePickerView: some View {
        ThemePickerView(selectedTheme: $settingsViewModel.selectedTheme)
    }
    
    var fontChooseView: some View {
        HStack {
            Text("Font")
                .font(.system(size: 22, weight: .medium))
            
            Spacer()
            
            Button {
                withAnimation {
                    settingsViewModel.selectedSheet = .font
                }
            } label: {
                HStack {
                    Text(settingsViewModel.selectedFont.name)
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 22, weight: .medium))
            }

        }
    }
}
