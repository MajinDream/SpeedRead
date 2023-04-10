//
//  MeasureQuestionPageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import SwiftUI

struct QuestionPageView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    var measureTestViewModel: MeasureTestViewModel
    
    var body: some View {
        questionsView
    }
}

extension QuestionPageView {
    private var questionsView: some View {
        VStack(spacing: 24) {
            Text("\((measureTestViewModel.currentQuestionIndex + 1).formatted() ) / \(measureTestViewModel.test.questions?.count.formatted() ?? "")")
            
            Text(.init(measureTestViewModel.currentQuestion?.question ?? ""))
                .padding(10)
                .font(.system(size: 30))
            
            ForEach((measureTestViewModel.currentQuestion?.answers ?? []).indexEnumerate(), id:\.0) { index, answer in
                Button {
                    measureTestViewModel.didTapAnswerButton(index: index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        measureTestViewModel.goToNextQuestion()
                        if measureTestViewModel.isLastQuestion {
                            navigationViewModel.addToPath(
                                path: &navigationViewModel.measurePath,
                                route: Route.measureResult(measureTestViewModel.measureResult)
                            )
                        } else {
                            navigationViewModel.addToPath(
                                path: &navigationViewModel.measurePath,
                                route: Route.question(measureTestViewModel)
                            )
                        }
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.srPrimary)
                        .padding(.horizontal, 20)
                        .overlay {
                            Text(answer)
                                .font(.system(size: 22).bold())
                                .padding(.horizontal, 20)
                                .foregroundColor(.primary)
                                .shadow(radius: 1)
                        }
                        .frame(height: 100)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.srBackground)
        .navigationTitle(measureTestViewModel.test.title)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuestionPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            QuestionPageView(measureTestViewModel: MeasureTestViewModel(test: .example))
                .environmentObject(NavigationViewModel())
        }
    }
}
