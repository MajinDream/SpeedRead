//
//  ExercisePageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

struct ExercisePageView: View {
    let exerciseViewModel: ExerciseViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(exerciseViewModel.exercises) { exercise in
                    ExerciseRowView(exercise: exercise)
                        .padding(.horizontal, 16)
                }
            }
            .shadow(radius: 4, y: 4)
        }
    }
}

struct ExercisePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePageView(exerciseViewModel: ExerciseViewModel())
    }
}
