//
//  MeasureResultViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.03.2023.
//

import Foundation
import Combine

final class MeasureResultViewModel: ObservableObject {
    @Published var result: MeasureResult
    var resultSubsription: AnyCancellable?
    
    init(result: MeasureResult) {
        self.result = result
    }
    
    func sendResults() async {
        let sendableResult = SendableMeasureResult (
            speed: Double(result.contentWordCount/(result.timeElapsed*60)),
            comp: Double(result.correctAnswerCount/result.questionCount),
            day: Date().ISO8601Format(),
            readingType: result.readingType
        )
        let request = MeasureRequest.sendResult(sendableResult).urlRequest
        
        resultSubsription = NetworkingManager.download(url: request)
            .decode(
                type: ResultResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (resultResponse) in
                    print("DEBUG: MeasureResult \(resultResponse.data)")
                    self?.resultSubsription?.cancel()
                }
            )
    }
}
