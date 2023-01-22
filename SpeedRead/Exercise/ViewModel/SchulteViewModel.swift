//
//  SchulteViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import Foundation

final class SchulteViewModel: ObservableObject {
    @Published var gridSize = 5
    @Published var isShowingDot = false
    @Published var isShuffle = false
    @Published var isPresentingSettings = false
//    @Published var numbers: [[SchulteCell]]
    //TODO: 1) Arrange Numbers 2) Refactor Colors 3) Refactor Constants 4) Refactor Network Layer
}

struct SchulteCell {
    let number: Int
    let isSelected = false
}
