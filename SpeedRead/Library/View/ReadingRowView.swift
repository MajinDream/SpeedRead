//
//  ReadingRowView.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.10.2022.
//

import SwiftUI

struct ReadingRowView: View {
    let reading: Reading
    
    var body: some View {
        NavigationLink(value: reading) {
            HStack(spacing: 14) {
                AsyncImageView(iconLink: reading.iconLink)
                    .frame(width: 60, height: 84)
                    .cornerRadius(8)
                    .padding(.leading, 12)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(reading.title)
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 4)
                    
                    
                    Text(reading.author)
                        .foregroundColor(.primary.opacity(0.5))
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 18)
                    
                    
                    ReadingProgressBar(pagesRead: reading.pagesRead ?? 17,
                                       pagesTotal: reading.pagesTotal ?? 100)
                }
                
                .padding(.vertical, 12)
                .padding(.trailing, 20)
            }
            .background(Color("secondary"))
            .cornerRadius(12)
        }
    }
}

struct ReadingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingRowView(reading: Reading.example)
    }
}
