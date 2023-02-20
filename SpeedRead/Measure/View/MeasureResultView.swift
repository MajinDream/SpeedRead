//
//  MeasureResultView.swift
//  SpeedRead
//
//  Created by Dias Manap on 20.02.2023.
//

import SwiftUI

struct MeasureResultView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    let result: MeasureResult
    
    var body: some View {
        finishedTestView
    }
}

extension MeasureResultView {
    private var finishedTestView: some View {
        VStack(spacing: 25) {
            VStack() {
                Text("Congratulations!")
                Text("You have finished the test")
                    .padding(.bottom, 20)
                
                Text("You read it in \(result.timeElapsed) sec")
                Text("Your speed is \(result.contentWordCount/result.timeElapsed) wpm")
                    .padding(.bottom, 20)
                
                Text("You answered \(result.correctAnswerCount) questions")
                Text("Comprehension is \((result.correctAnswerCount * 100/result.questionCount).formatted(.percent)) questions")
                    .padding(.bottom, 40)
            }
            .multilineTextAlignment(.center)
            .font(.title2)
            
            Button {
                navigationViewModel.goBack(count: result.questionCount + 2)
            } label: {
                Capsule()
                    .foregroundColor(.accentColor)
                    .frame(width: 150, height: 50)
                    .overlay {
                        Text("Done")
                            .foregroundColor(.primary)
                            .font(.system(size: 22).bold())
                    }
            }
        }
        .padding(30)
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.srBackground)
    }
}

struct MeasureResultView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureResultView(result: MeasureResult(timeElapsed: 10, contentWordCount: 100, correctAnswerCount: 10, questionCount: 10))
    }
}
