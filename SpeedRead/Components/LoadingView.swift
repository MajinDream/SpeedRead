//
//  LoadingView.swift
//  SpeedRead
//
//  Created by Dias Manap on 06.04.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Text("   Loading...")
                    .font(.headline)
            }
            .frame(width: 100, height: 100)
            .background(Color.white.opacity(0.6).cornerRadius(20))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .opacity(0.3)
    }
}
