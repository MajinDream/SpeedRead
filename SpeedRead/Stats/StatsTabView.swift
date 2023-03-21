//
//  StatsTabView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI
import Charts

struct StatsTabView: View {
    @StateObject private var statsViewModel = StatsViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 50) {
                todayView
                weekView
                monthView
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.srBackground)
        .task {
//            await statsViewModel.fetchStats()
        }
    }
}

extension StatsTabView {
    var todayView: some View {
        VStack(alignment: .leading) {
            Text("Today")
                .padding(.bottom, 8)
            HStack {
                HStack {
                    Image(systemName: "minus.circle.fill")
                    Text("Read: ")
                    Spacer()
                    Text((statsViewModel.stats.daySpeed?.formatted() ?? "") + " WPM")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary.opacity(0.2))
                }
                
                HStack {
                    Image(systemName: "arrow.up.circle.fill")
                    Text("Grasp:")
                    Spacer()
                    Text(statsViewModel.stats.dayComp?.formatted(.percent) ?? "")
                        .foregroundColor(.orange)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary.opacity(0.2))
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
    var weekView: some View {
        VStack(alignment: .leading) {
            Text("Weekly")
                .padding(.bottom, 8)
            HStack {
                HStack {
                    Image(systemName: "minus.circle.fill")
                    Text("Read: ")
                    Spacer()
                    Text((statsViewModel.stats.weekSpeed?.formatted() ?? "") + " WPM")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary.opacity(0.2))
                }
                
                HStack {
                    Image(systemName: "arrow.up.circle.fill")
                    Text("Grasp:")
                    Spacer()
                    Text(statsViewModel.stats.weekComp?.formatted(.percent) ?? "")
                        .foregroundColor(.orange)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary.opacity(0.2))
                }
            }
            .padding(.bottom, 10)
            
            Chart(statsViewModel.stats.weekData ?? []) {
                LineMark(
                    x: .value("Mount", $0.mount),
                    y: .value("Value", $0.value)
                )
                PointMark(
                    x: .value("Mount", $0.mount),
                    y: .value("Value", $0.value)
                )
            }
            .foregroundColor(.blue)
            .frame(height: 250)
        }
        .padding(.horizontal, 8)
    }
    
    var monthView: some View {
        VStack(alignment: .leading) {
            Text("Monthly")
                .padding(.bottom, 8)
            HStack {
                HStack {
                    Image(systemName: "minus.circle.fill")
                    Text("Read: ")
                    Spacer()
                    Text((statsViewModel.stats.monthSpeed?.formatted() ?? "") + " WPM")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary.opacity(0.2))
                }
                
                HStack {
                    Image(systemName: "arrow.up.circle.fill")
                    Text("Grasp:")
                    Spacer()
                    Text(statsViewModel.stats.monthComp?.formatted(.percent) ?? "")
                        .foregroundColor(.orange)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary.opacity(0.2))
                }
            }
            .padding(.bottom, 10)
            
            Chart(statsViewModel.stats.monthData ?? []) {
                BarMark(
                    x: .value("Mount", $0.mount),
                    y: .value("Value", $0.value)
                )
            }
            .foregroundColor(.orange)
            .frame(height: 250)
        }
        .padding(.horizontal, 8)
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

