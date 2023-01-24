//
//  SchulteViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

final class SchulteViewModel: ObservableObject {
    @Published var currentNumber = 1
    @Published var gridSize = 5
    @Published var isShowingDot = false
    @Published var isShuffle = false
    @Published var isPresentingSettings = false
    @Published var cells = [[SchulteCell]]()
    private var numbers = [Int]()
    
    init() {
        populateNumbers()
    }
    
    func populateNumbers() {
        numbers = Array(1...gridSize*gridSize).shuffled()
        cells.removeAll()
        var i = 0
        for _ in 0..<gridSize {
            var row = [SchulteCell]()
            for _ in 0..<gridSize {
                let cell = SchulteCell(number: numbers[i])
                i += 1
                row.append(cell)
            }
            cells.append(row)
            row.removeAll()
        }
    }

    func shuffleCells() {
        guard isShuffle else { return }
        cells.shuffle()
    }
    
    /*
     TODO: 1) Arrange Numbers
            2) Refactor Colors
     3) Refactor Constants
     4) Refactor Network Layer
     5) refactor ToolBar
     6) refactor big views
     */
}

final class SchulteCell: ObservableObject, Hashable {
    let number: Int
    @Published var isCorrect = false
    
    init(number: Int) {
        self.number = number
    }
    
    func correctCell(_ correctNumber: Int) -> Bool {
        if number == correctNumber {
            isCorrect = true
            return true
        } else {
            return false
        }
    }
    
    static func == (lhs: SchulteCell, rhs: SchulteCell) -> Bool {
        lhs.number == rhs.number
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }
}
