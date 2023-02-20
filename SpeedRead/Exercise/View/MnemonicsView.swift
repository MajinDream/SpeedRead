//
//  MnemonicsView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

struct MnemonicsView: View {
    @StateObject var mnemonicsViewModel = MnemonicsViewModel()
    @State var isWordHidden = true
    
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack {
            hiddenWord
            ZStack(alignment: .center) {
                backgroundTextField
                    .padding(50)
                foregroundTextField
            }
            Button("Completed") {
                mnemonicsViewModel.didTapComplete()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 10)
        .background(Color.srBackground)
        .navigationTitle("Mnemonics")
        .navigationBarTitleDisplayMode(.inline)
        .alert("You Won!", isPresented: $mnemonicsViewModel.isWon) {
            Button("Try Again?") { }
        } message: {
            Text("Good job, it was correct")
        }
        .alert("You Lost!", isPresented: $mnemonicsViewModel.isLost) {
            Button("Try Again?") { }
        } message: {
            Text("Aww, it was not correct.")
        }
        
    }

    private var hiddenWord: some View {
        HStack {
            ZStack {
                Text(mnemonicsViewModel.chosenWord.uppercased())
                    .font(.system(size: 40, weight: .regular))
                    .padding(5)
                    .onAppear {
                        isWordHidden.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            withAnimation() {
                                isWordHidden.toggle()
                            }
                        }
                    }
                
                Capsule()
                    .frame(width: 250, height: 50)
                    .foregroundColor(Color.accentColor)
                    .opacity(isWordHidden ? 1.0 : 0)
            }
            Button {
                isWordHidden.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation() {
                        isWordHidden.toggle()
                    }
                }
            } label: {
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: "eye")
                            .foregroundColor(.white)
                    }
            }

        }
    }
    
    private var backgroundTextField: some View {
        return TextField("", text: $mnemonicsViewModel.enteredWord)
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .multilineTextAlignment(.center)
            .keyboardType(.asciiCapable)
            .onChange(of: mnemonicsViewModel.enteredWord) { _ in
                mnemonicsViewModel.limitText()
            }
            .focused($focusedField, equals: .field)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.focusedField = .field
                }
            }
    }

    private var foregroundTextField: some View {
        HStack {
            ForEach(Array(mnemonicsViewModel.chosenWord.enumerated()), id: \.offset) { character in
                ZStack {
                    Text(mnemonicsViewModel.getLetter(at: character.offset).uppercased())
                        .font(Font.system(size: 27))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primary)
                    Circle()
                        .frame(height: 25)
                        .foregroundColor(Color.primary)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                        .opacity(mnemonicsViewModel.enteredWord.count <= character.offset ? 1 : 0)
                }
            }
        }
    }
}

struct MnemonicsView_Previews: PreviewProvider {
    static var previews: some View {
        MnemonicsView()
    }
}
