//
//  ChartView.swift
//  SpeedRead
//
//  Created by Dias Manap on 21.03.2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    let chartType: ChartDataType
    let data: [StatPoint]?
    
    var body: some View {
        Chart(data ?? []) {
            switch chartType {
            case .speed:
                LineMark(
                    x: .value("Mount", $0.mount),
                    y: .value("Value", $0.value)
                )
                PointMark(
                    x: .value("Mount", $0.mount),
                    y: .value("Value", $0.value)
                )
            case .comp:
                BarMark(
                    x: .value("Mount", $0.mount),
                    y: .value("Value", $0.value)
                )
            default:
                fatalError()
            }
        }
        .foregroundColor(chartType.color)
        .frame(height: 250)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chartType: .comp, data: StatsModel.example.weekDataComp)
    }
}
