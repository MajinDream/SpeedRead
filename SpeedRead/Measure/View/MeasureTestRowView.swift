//
//  MeasureRowView.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import SwiftUI

struct MeasureTestRowView: View {
    let test: MeasureTest
    
    var body: some View {
        NavigationLink(value: Route.measureTest(test)) {
            HStack(spacing: 14) {
                AsyncImageView(iconLink: test.iconLink)
                    .frame(width: 60, height: 80)
                    .cornerRadius(8)
                    .padding([.leading, .vertical], 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(test.title)
                        .foregroundColor(.primary)
                        .font(.system(size: 22, weight: .semibold))
                        .padding(.bottom, 4)
                    
                    if let subtitle = test.subtitle {
                        Text(subtitle)
                            .foregroundColor(.primary.opacity(0.5))
                            .font(.system(size: 16, weight: .semibold))
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

struct MeasureTestRowView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureTestRowView(test: MeasureTest.example)
    }
}
