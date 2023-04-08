//
//  StatsTabView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct StatsTabView: View {
    @StateObject private var statsViewModel = StatsViewModel()
    
    @State private var weeklyChart = ChartDataType.speed
    @State private var monthlyChart = ChartDataType.speed
    private var currentWeeklyData: [StatPoint] {
        switch weeklyChart {
        case .speed: return statsViewModel.stats.weekDataSpeed
        case .comp: return statsViewModel.stats.weekDataComp
        default: return []
        }
    }
    
    private var currentMonthlyData: [StatPoint] {
        switch monthlyChart {
        case .speed: return statsViewModel.stats.monthDataSpeed
        case .comp: return statsViewModel.stats.monthDataComp
        default: return []
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 50) {
                    todayView
                    weekView
                    monthView
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.srBackground)
            
            if statsViewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            await statsViewModel.fetchStats()
        }
        .refreshable {
            await statsViewModel.fetchStats()
        }
    }
}

extension StatsTabView {
    var todayView: some View {
        StatsHeaderView(
            speedData: statsViewModel.stats.daySpeed,
            graspData: statsViewModel.stats.dayComp,
            period: .today,
            currentType: .constant(.none)
        )
    }
    
    var weekView: some View {
        VStack(alignment: .leading) {
            StatsHeaderView(
                speedData: statsViewModel.stats.weekSpeed,
                graspData: statsViewModel.stats.weekComp,
                period: .week,
                currentType: $weeklyChart
            )
            .padding(.bottom, 10)
            
            if !currentWeeklyData.isEmpty {
                ChartView(chartType: weeklyChart, data: currentWeeklyData)
            }
        }
    }
    
    var monthView: some View {
        VStack(alignment: .leading) {
            StatsHeaderView(
                speedData: statsViewModel.stats.monthSpeed,
                graspData: statsViewModel.stats.monthComp,
                period: .month,
                currentType: $monthlyChart
            )
            .padding(.bottom, 10)
            
            if !currentMonthlyData.isEmpty {
                ChartView(chartType: monthlyChart, data: currentMonthlyData)
            }
        }
    }
}

enum ChartDataType {
    case speed
    case comp
    case none
    
    var color: Color {
        switch self {
        case .speed: return .blue
        case .comp: return .orange
        default: return .white
        }
    }
    
    var icon: String {
        switch self {
        case .speed: return "speedometer"
        case .comp: return "lightbulb.circle"
        default: return "question"
        }
    }
    
    var name: String {
        switch self {
        case .speed: return "Speed"
        case .comp: return "Grasp"
        default: return "NONE"
        }
    }
    
    func formattedData(data: Double?) -> String {
        switch self {
        case .speed: return String(format: "%.1f WPM", data ?? 0.0)
        case .comp: return String(format: "%.1f %%", (data ?? 0.0) * 100)
        default: return "NONE"
        }
    }
}

struct StatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StatsTabView()
        }
        .environmentObject(NavigationViewModel())
    }
}

