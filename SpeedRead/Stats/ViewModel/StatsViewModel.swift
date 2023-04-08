//
//  StatsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.03.2023.
//

import Foundation
import Combine

struct StatsModel: Codable {
    let id: String?
    let userId: String?
    let dataComp: [CompData]?
    let dataSpeed: [SpeedData]?
    
    var daySpeed: Double {
        dataSpeed?.first(where: {
            Date().timeIntervalSince($0.dayDate) < 24 * 60 * 60
        })?.speed ?? 0.0
    }
    var dayComp: Double {
        dataComp?.first(where: {
            Date().timeIntervalSince($0.dayDate) < 24 * 60 * 60
        })?.comp ?? 0.0
    }
    
    var weekDataSpeed: [StatPoint] {
        dataSpeed?.filter({
            Date().timeIntervalSince($0.dayDate) < 7 * 24 * 60 * 60
        }).map({
            StatPoint(mount: $0.dayDate.getFormattedDate(format: "E"), value: $0.speed ?? 0.0)
        }) ?? []
    }
    var weekDataComp: [StatPoint] {
        dataComp?.filter({
            Date().timeIntervalSince($0.dayDate) < 7 * 24 * 60 * 60
        }).map({
            StatPoint(mount: $0.dayDate.getFormattedDate(format: "E"), value: $0.comp ?? 0.0)
        }) ?? []
    }
    
    var weekSpeed: Double {
        var sum = 0.0
        weekDataSpeed.forEach {
            sum += $0.value
        }
        return sum/Double(weekDataSpeed.count)
    }
    var weekComp: Double {
        var sum = 0.0
        weekDataComp.forEach {
            sum += $0.value
        }
        return sum/Double(weekDataComp.count)
    }
    
    var monthDataSpeed: [StatPoint] {
        dataSpeed?.filter({
            Date().timeIntervalSince($0.dayDate) < 30 * 7 * 24 * 60 * 60
        }).map({
            StatPoint(mount: $0.dayDate.getFormattedDate(format: "dd/MM"), value: $0.speed ?? 0.0)
        }) ?? []
    }
    var monthDataComp: [StatPoint] {
        dataComp?.filter({
            Date().timeIntervalSince($0.dayDate) < 30 * 7 * 24 * 60 * 60
        }).map({
            StatPoint(mount: $0.dayDate.getFormattedDate(format: "dd/MM"), value: $0.comp ?? 0.0)
        }) ?? []
    }
    
    var monthSpeed: Double {
        var sum = 0.0
        monthDataSpeed.forEach {
            sum += $0.value
        }
        return sum/Double(monthDataSpeed.count)
    }
    var monthComp: Double {
        var sum = 0.0
        monthDataComp.forEach {
            sum += $0.value
        }
        return sum/Double(monthDataComp.count)
    }
    
    static var example: StatsModel {
        StatsModel(id: "", userId: "", dataComp: [
            CompData(id: "", day: "2023-04-03T08:47:05.000Z", readingType: "", comp: 0.32, statId: "")
        ], dataSpeed: [
            SpeedData(id: "", day: "2023-04-03T08:47:05.000Z", readingType: "", speed: 2.0, statId: "")
        ])
    }
}

struct SpeedData: Codable, Identifiable {
    let id: String?
    let day: String?
    let readingType: String?
    let speed: Double?
    let statId: String?
    
    var dayDate: Date {
        guard let day else { return Date() }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: day) ?? Date()
    }
}

struct CompData: Codable, Identifiable {
    let id: String?
    let day: String?
    let readingType: String?
    let comp: Double?
    let statId: String?
    
    var dayDate: Date {
        guard let day else { return Date() }
        return ISO8601DateFormatter().date(from: day) ?? Date()
    }
}

struct StatPoint: Identifiable, Codable {
    var id = UUID()
    var mount: String
    var value: Double
}

final class StatsViewModel: ObservableObject {
    @Published var stats: StatsModel = StatsModel.example
    @Published var isLoading = true
    var statsSubsription: AnyCancellable?
    
    func fetchStats() async {
        let request = StatsRequest.fetchStats.urlRequest
        statsSubsription = NetworkingManager.download(url: request)
            .decode(
                type: StatsResponse.self,
                decoder: JSONDecoder()
            )
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (statsResponse) in
                    self?.stats = statsResponse.data?.stat?.first(
                        where: {$0.userId == statsResponse.data?.user?.id}
                    ) ?? StatsModel.example
                    self?.isLoading = false
                    self?.statsSubsription?.cancel()
                }
            )
    }
}
