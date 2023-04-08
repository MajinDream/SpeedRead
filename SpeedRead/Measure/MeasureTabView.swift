//
//  TestView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct MeasureTabView: View {
    @StateObject private var measureViewModel = MeasureViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(measureViewModel.tests) { test in
                        MeasureTestRowView(test: test)
                            .padding(.horizontal, 16)
                    }
                }
                .shadow(radius: 4, y: 4)
            }
            .padding(.top, 10)
            .background(Color.srBackground)
            .navigationBarTitleDisplayMode(.large)
            
            if measureViewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            measureViewModel.isLoading = true
            await measureViewModel.fetchTests()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MeasureTabView()
                .environmentObject(NavigationViewModel())
        }
    }
}
