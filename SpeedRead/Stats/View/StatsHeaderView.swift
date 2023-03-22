//
//  StatsHeaderView.swift
//  SpeedRead
//
//  Created by Dias Manap on 21.03.2023.
//

import SwiftUI

struct StatsHeaderView: View {
    enum Period: String {
        case today = "Today"
        case week = "Weekly"
        case month = "Monthly"
    }
    
    let speedData: Double?
    let graspData: Double?
    let period: Period?
    @Binding var currentType: ChartDataType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text((period ?? .today).rawValue)
                .padding(.bottom, 8)
            HStack {
                StatsHeaderSectionView(
                    type: .speed,
                    data: speedData,
                    isPicked: currentType == .speed
                ).onTapGesture {
                    withAnimation {
                        currentType = .speed
                    }
                }
                
                StatsHeaderSectionView(
                    type: .comp,
                    data: graspData,
                    isPicked: currentType == .comp
                ).onTapGesture {
                    withAnimation {
                        currentType = .comp
                    }
                }
            }
        }
    }
}


struct StatsHeaderSectionView: View {
    let type: ChartDataType
    let data: Double?
    let isPicked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: type.icon)
            Text(type.name)
            Spacer()
            Text(type.formattedData(data: data))
                .foregroundColor(type.color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 14)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.secondary.opacity(isPicked ? 0.4 : 0.2))
        }
    }
}
struct StatsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StatsHeaderView(speedData: 220, graspData: 0.75, period: .today, currentType: .constant(.comp))
    }
}
