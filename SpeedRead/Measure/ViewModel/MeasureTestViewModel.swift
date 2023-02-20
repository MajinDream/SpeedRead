//
//  MeasureTestViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import Foundation

final class MeasureTestViewModel: ObservableObject {
    @Published var test: MeasureTest
    @Published var currentQuestionIndex = 0
    @Published var correctAnswerIndex = -1
    @Published var timeElapsed = 0
    @Published var correctAnswerCount = 0
    private var navigationViewModel: NavigationViewModel?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var startDate = Date.now
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < test.questions?.count ?? 0 else {
            return nil
        }
        return test.questions?[currentQuestionIndex]
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex == test.questions?.count 
    }

    var measureResult: MeasureResult {
        MeasureResult(
            timeElapsed: timeElapsed,
            contentWordCount: test.content?.count ?? 10,
            correctAnswerCount: correctAnswerCount,
            questionCount: test.questions?.count ?? 4
        )
    }
    
    init(test: MeasureTest) {
        self.test = test
    }

    func getNextQuestion() -> Question {
        return test.questions?[0] ?? Question.example4
    }

    func goToNextQuestion() {
        self.correctAnswerIndex = -1
        
        // started the test
        if currentQuestionIndex == 0 {
            timer.upstream.connect().cancel()
        }
        
        currentQuestionIndex += 1
    }

    func didTapAnswerButton(index: Int) {
        guard let correctAnswerIndex = test.questions?[currentQuestionIndex].correctAnswer else { return }
        self.correctAnswerIndex = correctAnswerIndex
        print("DEBUG: \(correctAnswerIndex)")
        print("DEBUG: \(index)")
        if correctAnswerIndex == index { correctAnswerCount += 1 }
    }
}

extension MeasureTestViewModel: Equatable, Hashable {
    static func == (lhs: MeasureTestViewModel, rhs: MeasureTestViewModel) -> Bool {
        return lhs.test == rhs.test &&
        lhs.currentQuestionIndex == rhs.currentQuestionIndex &&
        lhs.correctAnswerIndex == rhs.correctAnswerIndex &&
        lhs.timeElapsed == rhs.timeElapsed &&
        lhs.correctAnswerCount == rhs.correctAnswerCount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(test)
        hasher.combine(currentQuestionIndex)
        hasher.combine(correctAnswerIndex)
        hasher.combine(timeElapsed)
        hasher.combine(correctAnswerCount)
    }
}
