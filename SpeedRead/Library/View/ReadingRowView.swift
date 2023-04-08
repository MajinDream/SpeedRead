//
//  ReadingRowView.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.10.2022.
//

import SwiftUI
import OrderedCollections

struct ReadingRowView: View {
    let reading: Reading
    let readingPages: OrderedDictionary<Int, [String]>?
    let currentPage: Int
    
    init(reading: Reading) {
        self.reading = reading
        self.readingPages = OrderedDictionary<Int, [String]>.load(on: .cachesDirectory, fromFileName: "\(reading.id).txt")
        self.currentPage = defaults.integer(forKey: "PageFor\(reading.id)")
    }
    
    var body: some View {
        NavigationLink(value: Route.reading(reading)) {
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
                    
                    
                    ReadingProgressBar(
                        pagesRead: currentPage ?? 17,
                        pagesTotal: readingPages?.count ?? 100
                    )
                }
                
                .padding(.vertical, 12)
                .padding(.trailing, 20)
            }
            .background(Color.srSecondary)
            .cornerRadius(12)
        }
    }
}

struct ReadingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingRowView(reading: Reading.example)
    }
}
