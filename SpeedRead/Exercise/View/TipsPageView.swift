//
//  TipsPageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

//TODO: add sort by topics

import SwiftUI

struct TipsPageView: View {
    let exerciseViewModel: ExerciseViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(exerciseViewModel.tips) { tip in
                    TipRowView(article: tip)
                        .padding(.horizontal, 16)
                }
            }
            .shadow(radius: 4, y: 4)
        }
    }
}

struct TipsPageView_Previews: PreviewProvider {
    static var previews: some View {
        TipsPageView(exerciseViewModel: ExerciseViewModel())
    }
}
