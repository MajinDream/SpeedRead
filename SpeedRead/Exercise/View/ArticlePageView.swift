//
//  ArticlePage.swift
//  SpeedRead
//
//  Created by Dias Manap on 30.01.2023.
//

import SwiftUI

struct ArticlePageView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    let article: Article
    
    var body: some View {
        ScrollView {
            AsyncImageView(iconLink: article.iconLink)
                .scaledToFit()
                .cornerRadius(16)
                .padding(.vertical, 16)
            Text(.init(article.content ?? ""))
                .padding(.horizontal, 10)
                .font(
                    settingsViewModel.selectedFont == .sfProDisplay
                    ? .system(size: settingsViewModel.fontSize, weight: .regular)
                    : .custom(settingsViewModel.selectedFont.name, size: settingsViewModel.fontSize)
                )
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .background(Color.srBackground)
        .navigationTitle(article.title)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            backToolBarItem
        }
    }
}

extension ArticlePageView {
    var backToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                navigationViewModel.goBack(
                    path: &navigationViewModel.trainingPath
                )
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
            }

        }
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ArticlePageView(article: Article.example)
        }
    }
}
