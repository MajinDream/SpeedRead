//
//  SettingsView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct SettingsTabView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            switch settingsViewModel.selectedSheet {
            case .reading:
                SettingsView()
                    .environmentObject(settingsViewModel)
                    .presentationDetents([.fraction(0.8)])
            case .font:
                FontsSheetView()
                    .environmentObject(settingsViewModel)
                    .presentationDetents([.fraction(0.8)])
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.srBackground)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
