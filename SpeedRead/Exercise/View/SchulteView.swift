//
//  SchulteView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

struct SchulteView: View {
    @StateObject private var schulteViewModel = SchulteViewModel()
    
    var body: some View {
        Grid {
            ForEach(0..<schulteViewModel.gridSize, id: \.self) { row in
                GridRow {
                    ForEach(0..<schulteViewModel.gridSize, id: \.self) { col in
                        SchulteCellView(number: row + col)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 10)
        .background(Color("background"))
        .navigationTitle("Schulte Table")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    schulteViewModel.isPresentingSettings = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
        .sheet(isPresented: $schulteViewModel.isPresentingSettings) {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                SchulteSettingsView(viewModel: schulteViewModel)
                    .presentationDetents([.fraction(0.3)])
            }
            .foregroundColor(Color.accentColor)
        }
        .overlay {
            Circle()
                .stroke(lineWidth: 2)
                .background(Circle().fill(schulteViewModel.isShowingDot ? .white : .clear))
                .foregroundColor(schulteViewModel.isShowingDot ? .red : .clear)
                .frame(width: 8, height: 8)
        }
    }
}

struct SchulteCellView: View {
    let number: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .aspectRatio(contentMode: .fit)
            .overlay {
                Text(number.formatted())
                    .foregroundColor(.black)
                    .font(.system(size: 35, weight: .bold))
            }
    }
}

struct SchulteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchulteView()
        }
    }
}
