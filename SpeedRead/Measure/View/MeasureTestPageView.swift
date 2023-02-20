//
//  MeasureTestPageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import SwiftUI

struct MeasureTestPageView: View {
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    @ObservedObject var measureTestViewModel: MeasureTestViewModel
    
    init(test: MeasureTest) {
        self.measureTestViewModel = MeasureTestViewModel(test: test)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("\(measureTestViewModel.timeElapsed) sec")
                    .onReceive(measureTestViewModel.timer) { firedDate in
                        measureTestViewModel.timeElapsed = Int(firedDate.timeIntervalSince(measureTestViewModel.startDate))
                    }
                    .foregroundColor(.srPrimary)
                
                Text(.init(measureTestViewModel.test.content ?? ""))
                    .padding(.horizontal, 10)
                    .font(.system(size: 20))
                
                NavigationLink(value: Route.question(measureTestViewModel)) {
                    Capsule()
                        .foregroundColor(.accentColor)
                        .frame(width: 150, height: 50)
                        .overlay {
                            Text("Done")
                                .foregroundColor(.primary)
                                .font(.system(size: 22).bold())
                        }       
                }
                .onTapGesture {
                    measureTestViewModel.goToNextQuestion()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.srBackground)
        .navigationTitle(measureTestViewModel.test.title)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeasureTestPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MeasureTestPageView(test: MeasureTest.example)
        }
    }
}
