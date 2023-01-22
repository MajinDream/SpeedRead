//
//  SchulteSettingsView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

struct SchulteSettingsView: View {
    @ObservedObject var viewModel: SchulteViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            gridSizeView
            showDotView
            shuffleNumbersView
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

extension SchulteSettingsView {
    var gridSizeView: some View {
        HStack {
            Text("Grid size")
            Spacer()
            Picker("Grid size", selection: $viewModel.gridSize) {
                ForEach(2..<6) { num in
                    Text(num.formatted()).tag(num)
                }
            }
            .frame(width: 75, height: 100)
            .pickerStyle(.wheel)
        }
    }

    var showDotView: some View {
        Toggle("Turn on dot in the center?", isOn: $viewModel.isShowingDot)
    }

    var shuffleNumbersView: some View {
        Toggle("Shuffle numbers?", isOn: $viewModel.isShuffle)
    }
}

struct SchulteSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SchulteSettingsView(viewModel: SchulteViewModel())
    }
}
