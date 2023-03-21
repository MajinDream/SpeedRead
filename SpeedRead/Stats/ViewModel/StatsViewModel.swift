//
//  StatsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.03.2023.
//

import Foundation
import Combine

struct StatsModel: Codable {
    let daySpeed: Double?
    let dayComp: Double?
    
    let weekSpeed: Double?
    let weekComp: Double?
    let weekData: [StatPoint]?
    
    let monthSpeed: Double?
    let monthComp: Double?
    let monthData: [StatPoint]?
    
    static var example: StatsModel {
        StatsModel(
            daySpeed: 241,
            dayComp: 0.59,
            weekSpeed: 312,
            weekComp: 0.87,
            weekData: [
                StatPoint(mount: "Mon", value: 144),
                StatPoint(mount: "Tue", value: 100),
                StatPoint(mount: "Wed", value: 162),
                StatPoint(mount: "Thu", value: 201),
                StatPoint(mount: "Fri", value: 170),
                StatPoint(mount: "Sat", value: 243),
                StatPoint(mount: "Sun", value: 271)
            ],
            monthSpeed: 352,
            monthComp: 0.73,
            monthData: [
                StatPoint(mount: "W1", value: 214),
                StatPoint(mount: "W2", value: 180),
                StatPoint(mount: "W3", value: 251),
                StatPoint(mount: "W4", value: 223),
            ]
        )
    }
}

struct StatPoint: Identifiable, Codable {
    var id = UUID()
    var mount: String
    var value: Double
}





final class StatsViewModel: ObservableObject {
    @Published var stats: StatsModel = StatsModel.example
    var statsSubsription: AnyCancellable?
    
    func fetchStats() async {
        let request = StatsRequest.fetchStats.url
        statsSubsription = NetworkingManager.download(url: request)
            .decode(
                type: StatsModel.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (statsResponse) in
                    self?.stats = statsResponse
                    self?.statsSubsription?.cancel()
                }
            )
    }
}
