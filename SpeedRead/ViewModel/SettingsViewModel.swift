//
//  SettingsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var readingMode = ReadingMode.highlight
    @Published var speed = 220.0
    @Published var length = 12.0
    @Published var constrast = 50.0
    @Published var fontSize = 18.0
    @Published var presentSettings = false
    @Published var selectedTheme = ThemeType.darkGray
    @Published var selectedFont = Fonts.sfProDisplay
    @Published var selectedSheet = SelectedSettingsSheet.reading
}
