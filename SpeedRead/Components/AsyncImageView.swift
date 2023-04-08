//
//  AsyncImageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 27.10.2022.
//

import SwiftUI

struct AsyncImageView: View {
    let iconLink: String?
    var iconUrl: URL? {
        guard let link = iconLink,
              let url = URL(string: link) else { return nil }
        return url
    }

    var body: some View {
        AsyncImage(url: iconUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .font(.largeTitle)
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(iconLink: "")
    }
}
