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
    var measureSubsription: AnyCancellable?
    
    func fetchTests() async {
        tests = [MeasureTest.example]
        
        guard let url = URL(string: "http://13.115.20.106/api/books/list") else {
            print("Invalid URL")
            return
        }
        
        measureSubsription = NetworkingManager.download(url: url)
            .decode(type: [MeasureTest].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (tests) in
                self?.tests = tests
                self?.measureSubsription?.cancel()
            })
    }
    
}
