//
//  MnemonicsView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

struct MnemonicsView: View {
    @StateObject var mnemonicsViewModel = MnemonicsViewModel()

    var body: some View {
        HStack {
            ForEach(0..<mnemonicsViewModel.chosenWord.count, id: \.self) { i in
                MnemonicsLetterView(isSelected: i == mnemonicsViewModel.currentIndex, letter: mnemonicsViewModel.chosenWord[i ..< i + 1])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 10)
        .background(Color("background"))
        .navigationTitle("Mnemonics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MnemonicsLetterView: View {
    @State var isSelected = false
    @State var letter: String
    
    var body: some View {
        Text(letter)
            .foregroundColor(Color.black)
            .frame(width: UIScreen.main.bounds.size.width/9.375, height: UIScreen.main.bounds.size.width/6.25)
            .background(Color.white.opacity(0.7))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .green : .clear, lineWidth: 3)
                .shadow(radius: 1))
    }
}

struct MnemonicsView_Previews: PreviewProvider {
    static var previews: some View {
        MnemonicsView()
    }
}
