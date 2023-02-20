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
            ForEach(schulteViewModel.cells, id: \.self) { row in
                GridRow {
                    ForEach(row, id: \.self) { cell in
                        SchulteCellView(cell: cell)
                            .onTapGesture {
                                if cell.correctCell(schulteViewModel.currentNumber) {
                                    schulteViewModel.incrementNumber()
                                    schulteViewModel.shuffleCells()
                                }
                            }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 10)
        .background(Color.srBackground)
        .navigationTitle("Schulte Table")
        .navigationBarTitleDisplayMode(.inline)
        .alert("You Won!", isPresented: $schulteViewModel.isWon) {
            Button("Cancel", role: .cancel) {}
            Button("Try Again?") {
                schulteViewModel.populateNumbers()
            }
        } message: {
            Text("Good job, You finished the game.")
        }
        .toolbar {
            restartToolBarView
            settingsToolBarView
        }
        .overlay { redDotView }
        .sheet(isPresented: $schulteViewModel.isPresentingSettings) {
            settingsSheetView
        }
        .onChange(of: schulteViewModel.gridSize) { _ in
            schulteViewModel.populateNumbers()
        }
    }
}

extension SchulteView {
    var restartToolBarView: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                schulteViewModel.populateNumbers()
            } label: {
                Image(systemName: "restart")
                    .font(.system(size: 17, weight: .semibold))
            }
        }
    }
    
    var settingsToolBarView: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                schulteViewModel.isPresentingSettings = true
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 17, weight: .semibold))
            }
        }
    }

    var settingsSheetView: some View {
        ZStack {
            Color.srBackground.edgesIgnoringSafeArea(.all)
            SchulteSettingsView(viewModel: schulteViewModel)
                .presentationDetents([.fraction(0.3)])
        }
        .foregroundColor(Color.accentColor)
    }

    var redDotView: some View {
        Circle()
            .stroke(lineWidth: 2)
            .background(Circle().fill(schulteViewModel.isShowingDot ? .white : .clear))
            .foregroundColor(schulteViewModel.isShowingDot ? .red : .clear)
            .frame(width: 8, height: 8)
    }
}

struct SchulteCellView: View {
    @ObservedObject var cell: SchulteCell
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .aspectRatio(contentMode: .fit)
            .overlay {
                Text(cell.number.formatted())
                    .foregroundColor(.black)
                    .font(.system(size: 35, weight: .bold))
            }
            .foregroundColor(cell.isCorrect ? .green : .white)
    }
}

struct SchulteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SchulteView()
        }
    }
}
