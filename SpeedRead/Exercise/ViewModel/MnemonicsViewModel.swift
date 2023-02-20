//
//  MnemonicsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 24.01.2023.
//

import Foundation

final class MnemonicsViewModel: ObservableObject {
    @Published var chosenWord = ""
    @Published var enteredWord = ""
    @Published var currentIndex = 0
    @Published var isWon = false
    @Published var isLost = false
    @Published var wordList = [String]()

    init() {
        fetchWordList()
        chooseWord()
    }
    
    private func fetchWordList() {
        wordList = ["alpha", "beta", "gamma", "tetta", "omega", "cringe"]
    }

    func chooseWord() {
        chosenWord = wordList.randomElement() ?? "Test"
    }

    func didTapComplete() {
        if chosenWord.uppercased() == enteredWord.uppercased() {
            isWon = true
        } else {
            isLost = true
        }
        enteredWord = ""
        chooseWord()
    }

    func getLetter(at index: Int) -> String {
        guard self.enteredWord.count > index else {
            return ""
        }
        return self.enteredWord[index]
    }
    
    func limitText() {
        if enteredWord.count > chosenWord.count {
            enteredWord = String(enteredWord.prefix(chosenWord.count))
        }
    }
}
