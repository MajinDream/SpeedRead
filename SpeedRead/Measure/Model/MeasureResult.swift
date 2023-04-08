//
//  MeasureResult.swift
//  SpeedRead
//
//  Created by Dias Manap on 20.02.2023.
//

import Foundation

struct MeasureResult: Codable, Equatable, Hashable {
    let timeElapsed: Int
    let contentWordCount: Int
    let correctAnswerCount: Int
    let questionCount: Int
    let readingType: String
}

struct SendableMeasureResult: Codable, Equatable, Hashable {
    let speed: Double
    let comp: Double
    let day: String
    let readingType: String
}
