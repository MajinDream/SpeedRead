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
                                //TODO: Exercise.allCases
    @Published var tips = [Article]()
    @Published var isLoading = false
    
    var tipsSubsription: AnyCancellable?
    
    func fetchTips() async {
        let request = TipsRequest.fetchTips.urlRequest
        tipsSubsription = NetworkingManager.download(url: request)
            .decode(
                type: TipsResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (tipsResponse) in
                    if let tips = tipsResponse.articles {
                        self?.tips = tips
                    }
                    self?.isLoading = false
                    self?.tipsSubsription?.cancel()
                }
            )
    }
}
