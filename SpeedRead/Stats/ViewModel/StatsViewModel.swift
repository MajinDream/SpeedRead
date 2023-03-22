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
    let weekDataSpeed: [StatPoint]?
    let weekDataComp: [StatPoint]?
    
    let monthSpeed: Double?
    let monthComp: Double?
    let monthDataSpeed: [StatPoint]?
    let monthDataComp: [StatPoint]?
    
    static var example: StatsModel {
        StatsModel(
            daySpeed: 241,
            dayComp: 0.59,
            weekSpeed: 312,
            weekComp: 0.87,
            weekDataSpeed: [
                StatPoint(mount: "Mon", value: 144),
                StatPoint(mount: "Tue", value: 100),
                StatPoint(mount: "Wed", value: 162),
                StatPoint(mount: "Thu", value: 201),
                StatPoint(mount: "Fri", value: 170),
                StatPoint(mount: "Sat", value: 243),
                StatPoint(mount: "Sun", value: 271)
            ],
            weekDataComp: [
                StatPoint(mount: "Mon", value: 0.74),
                StatPoint(mount: "Tue", value: 0.70),
                StatPoint(mount: "Wed", value: 0.76),
                StatPoint(mount: "Thu", value: 0.90),
                StatPoint(mount: "Fri", value: 0.77),
                StatPoint(mount: "Sat", value: 0.74),
                StatPoint(mount: "Sun", value: 0.87)
            ],
            monthSpeed: 352,
            monthComp: 0.73,
            monthDataSpeed: [
                StatPoint(mount: "W1", value: 214),
                StatPoint(mount: "W2", value: 180),
                StatPoint(mount: "W3", value: 251),
                StatPoint(mount: "W4", value: 223),
            ],
            monthDataComp: [
                StatPoint(mount: "W1", value: 0.72),
                StatPoint(mount: "W2", value: 0.82),
                StatPoint(mount: "W3", value: 0.72),
                StatPoint(mount: "W4", value: 0.65),
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
