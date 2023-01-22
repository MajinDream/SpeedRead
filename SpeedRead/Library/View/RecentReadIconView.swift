//
//  RecentReadIconView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.10.2022.
//

import SwiftUI

struct RecentReadIconView: View {
    let reading: Reading
    
    var body: some View {
        NavigationLink(value: reading) {
            AsyncImageView(iconLink: reading.iconLink)
                .frame(width: 130, height: 130)
                .cornerRadius(12)
        }
    }
}

struct RecentReadIconView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(red: 0.114, green: 0.114, blue: 0.114)
            RecentReadIconView(reading: Reading.example)
        }
    }
}
