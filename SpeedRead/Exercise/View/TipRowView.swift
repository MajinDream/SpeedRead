//
//  TipRowView.swift
//  SpeedRead
//
//  Created by Dias Manap on 30.01.2023.
//

import SwiftUI

struct TipRowView: View {
    let article: Article
    
    var body: some View {
        NavigationLink(value: Route.article(article)) {
            HStack(spacing: 14) {
                AsyncImageView(iconLink: article.iconLink)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .padding([.leading, .vertical], 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(article.title)
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 4)
                    
                    if let subtitle = article.subtitle {
                        Text(subtitle)
                            .foregroundColor(.primary.opacity(0.5))
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.bottom, 4)
                    }
                }
                .padding(.vertical, 13)
                .padding(.trailing, 20)
                
                Spacer()
            }
            .background(Color.srSecondary)
            .cornerRadius(12)
        }
    }
}

struct TipRowView_Previews: PreviewProvider {
    static var previews: some View {
        TipRowView(article: Article.example)
    }
}
