//
//  MeasureViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import Foundation
import Combine

final class MeasureViewModel: ObservableObject {
    @Published var tests = [MeasureTest]()
    @Published var isLoading = false
    
    var measureSubsription: AnyCancellable?
    var questionsSubsription: AnyCancellable?
    
    func fetchTests() async {
        isLoading = true
        let request = MeasureRequest.fetchTests.urlRequest
        measureSubsription = NetworkingManager.download(url: request)
            .decode(
                type: MeasureResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (measureResponse) in
                    if let tests = measureResponse.paragraphs {
                        self?.tests = tests
                        self?.fetchQuestions()
                    }
                    self?.isLoading = false
                    self?.measureSubsription?.cancel()
                }
            )
    }
    
    func fetchQuestions() {
        guard !tests.isEmpty else {
            isLoading = false
            questionsSubsription?.cancel()
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let request = MeasureRequest.fetchQuestions.urlRequest
        questionsSubsription = NetworkingManager.download(url: request)
            .decode(
                type: QuestionsResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (questionsResponse) in
                    guard let questions = questionsResponse.questions else { return }
                    for question in questions {
                        var quests = [Question]()
                        guard let index = self?.tests.firstIndex(where: { $0.id == question.paragraphId }) else {
                            continue
                        }
                        if self?.tests[index].questions == nil {
                            self?.tests[index].questions = []
                        }
                        self?.tests[index].questions?.append(question)
                    }
                    self?.tests = self?.tests ?? []
                    print("DEBUG tests: \(self?.tests)")
                    self?.isLoading = false
                    self?.questionsSubsription?.cancel()
                }
            )
    }
}
