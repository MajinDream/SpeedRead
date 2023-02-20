//
//  NavigationViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 07.11.2022.
//

import SwiftUI

enum Route: Hashable {
    case reading(Reading)
    case exercise(Exercise)
    case article(Article)
    case measureTest(MeasureTest)
    case question(MeasureTestViewModel)
    case measureResult(MeasureResult)

    @ViewBuilder
    var destinationView: some View {
        switch self {
        case let .reading(reading):
            ReadingPageView(reading: reading)
        case let .article(article):
            ArticlePageView(article: article)
        case let .exercise(exercise):
            exercise.getExerciseView()
        case let .measureTest(test):
            MeasureTestPageView(test: test)
        case let .question(measureTestViewModel):
            QuestionPageView(measureTestViewModel: measureTestViewModel)
        case let .measureResult(result: result):
            MeasureResultView(result: result)
        }
    }
}

final class NavigationViewModel: ObservableObject {
    @Published var path: NavigationPath

    init() {
        path = NavigationPath()
    }
    
    func clearPath() {
        path.removeLast(path.count)
    }

    func addToPath(route: Route) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goBack(count: Int) {
        path.removeLast(count)
    }
}
