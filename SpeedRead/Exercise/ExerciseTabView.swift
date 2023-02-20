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
        VStack {
            pagePickerView
            exerciseViewModel.selectedPage.getPageView(viewModel: exerciseViewModel)
            Spacer()
        }
        .background(Color.srBackground)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            sortToolBarItem
            addToolBarItem
        }
        .task {
            exerciseViewModel.fetchArticles()
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

    var sortToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                print("WIP SORT")
            } label: {
                HStack {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                    Text("Sort")
                }
                .font(.system(size: 17, weight: .semibold))
            }
        }
    }
    
    var addToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                print("WIP ADD")
            } label: {
                HStack {
                    Text("Add")
                    Image(systemName: "plus")
                }
                .font(.system(size: 17, weight: .semibold))
            }
        }
    }
}

struct ExerciseTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTabView()
            .environmentObject(NavigationViewModel())
    }
}
