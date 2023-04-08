//
//  MeasureResultView.swift
//  SpeedRead
//
//  Created by Dias Manap on 20.02.2023.
//

import SwiftUI


struct MeasureResultView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @ObservedObject var measureResultViewModel: MeasureResultViewModel
    
    init(result: MeasureResult) {
        self.measureResultViewModel = MeasureResultViewModel(result: result)
    }
    
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
                
                Text("You read it in \(measureResultViewModel.result.timeElapsed) sec")
                Text("Your speed is \(measureResultViewModel.result.contentWordCount/measureResultViewModel.result.timeElapsed) wpm")
                    .padding(.bottom, 20)
                
                Text("You answered \(measureResultViewModel.result.correctAnswerCount) questions")
                Text("Comprehension is \((measureResultViewModel.result.correctAnswerCount * 100/measureResultViewModel.result.questionCount).formatted(.percent)) questions")
                    .padding(.bottom, 40)
            }
            .multilineTextAlignment(.center)
            .font(.title2)
            
            Button {
                Task {
                    await measureResultViewModel.sendResults()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    navigationViewModel.goBack(
                        path: &navigationViewModel.measurePath,
                        count: measureResultViewModel.result.questionCount + 2
                    )
                }
                //TODO: posledovatelno
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
        MeasureResultView(result: MeasureResult(timeElapsed: 0, contentWordCount: 0, correctAnswerCount: 0, questionCount: 0, readingType: ""))
    }
}
