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
    @Published var trainingPath: NavigationPath
    @Published var measurePath: NavigationPath
    @Published var libraryPath: NavigationPath
    @Published var statsPath: NavigationPath
    @Published var settingsPath: NavigationPath

    init() {
        trainingPath = NavigationPath()
        measurePath = NavigationPath()
        libraryPath = NavigationPath()
        statsPath = NavigationPath()
        settingsPath = NavigationPath()
    }
    
    func clearPath(path: inout NavigationPath) {
        path.removeLast(path.count)
    }

    func addToPath(path: inout NavigationPath, route: Route) {
        path.append(route)
    }
    
    func goBack(path: inout NavigationPath) {
        path.removeLast()
    }
    
    func goBack(path: inout NavigationPath, count: Int) {
        path.removeLast(count)
    }
}
