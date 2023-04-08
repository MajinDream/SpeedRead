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
    @Published var isLoading = true
    
    var measureSubsription: AnyCancellable?
    var questionsSubsription: AnyCancellable?
    
    func fetchTests() async {
        tests = [MeasureTest.example]
        isLoading = false
        return
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
        
        for test in tests.enumerated() {
            let request = MeasureRequest.fetchQuestions(test.element.id).urlRequest
            questionsSubsription = NetworkingManager.download(url: request)
                .decode(
                    type: QuestionsResponse.self,
                    decoder: JSONDecoder()
                )
                .sink(
                    receiveCompletion: NetworkingManager.handleCompletion,
                    receiveValue: { [weak self] (questionsResponse) in
                        self?.tests[test.offset].questions = questionsResponse.questions
                        self?.isLoading = false
                        self?.questionsSubsription?.cancel()
                    }
                )
        }
    }
}
