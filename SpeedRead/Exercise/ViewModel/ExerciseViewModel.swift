//
//  ExerciseViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import Foundation

final class ExerciseViewModel: ObservableObject {
    @Published var selectedPage = ExerciseTabView.ExercisePage.exercises
    @Published var exercises = Exercise.allCases
    
    // Fetch Images
}
