//
//  MnemonicsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 24.01.2023.
//

import Foundation

final class MnemonicsViewModel: ObservableObject {
    @Published var chosenWord = "test"
    @Published var currentIndex = 0
    @Published var wordList = [String]()

    init() {
        fetchWordList()
    }
    
    private func fetchWordList() {
        wordList = ["alpha", "beta", "gamma", "tetta", "omega", "cringe"]
    }
}
