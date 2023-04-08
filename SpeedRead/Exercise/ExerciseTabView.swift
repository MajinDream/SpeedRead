//
//  ExerciseView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct ExerciseTabView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                pagePickerView
                exerciseViewModel.selectedPage.getPageView(viewModel: exerciseViewModel)
                Spacer()
            }
            .background(Color.srBackground)
            .navigationBarTitleDisplayMode(.large)
            
            if exerciseViewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            exerciseViewModel.isLoading = true
            await exerciseViewModel.fetchTips()
        }
    }
}

extension ExerciseTabView {
    enum ExercisePage {
        case exercises
        case tips
        
        @ViewBuilder
        func getPageView(viewModel: ExerciseViewModel) -> some View {
            switch self {
            case .exercises: ExercisePageView(exerciseViewModel: viewModel)
            case .tips: TipsPageView(exerciseViewModel: viewModel)
            }
        }
    }
    
    var pagePickerView: some View {
        Picker("PageSelector", selection: $exerciseViewModel.selectedPage) {
            Text("Exercises").tag(ExercisePage.exercises)
            Text("Tips").tag(ExercisePage.tips)
        }.onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "primary")
        }
        .pickerStyle(.segmented)
        .padding(16)
    }
}

struct ExerciseTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTabView()
            .environmentObject(NavigationViewModel())
    }
}
