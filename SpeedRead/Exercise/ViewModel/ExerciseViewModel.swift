//
//  ExerciseViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import Foundation
import Combine

final class ExerciseViewModel: ObservableObject {
    @Published var selectedPage = ExerciseTabView.ExercisePage.exercises
    @Published var exercises = [Exercise.schulte, Exercise.mnemonics]
                                // Exercise.allCases
    @Published var tips = Array(repeating: Article.example, count: 1)
    
    var test: AnyCancellable?
    
    func fetchArticles() {
        //TODO
    }
}
