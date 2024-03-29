//
//  ReadingProgressBar.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.10.2022.
//

import SwiftUI

struct ReadingProgressBar: View {
    let pagesRead: Int
    let pagesTotal: Int
    var percentage: Double { Double(pagesRead) / Double(pagesTotal) }
    var pagesLeft: Int { pagesTotal - pagesRead }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(.primary)

                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: geometry.size.width * percentage)
                        .foregroundColor(.srHelper)
                }
            }
            .frame(height: 6)
            
            HStack(spacing: 0) {
                Text(String(format: "%.1f%%", percentage * 100))
                Text(" or \(pagesLeft) pages left")
                Spacer()
                Text("\(pagesTotal) pages total")
            }
            .font(.system(size: 10, weight: .semibold))
            .foregroundColor(.srHelper)
        }
    }
}

struct ReadingProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ReadingProgressBar(pagesRead: 120, pagesTotal: 500)
    }
}
