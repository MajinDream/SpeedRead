//
//  SettingsView.swift
//  SpeedRead
//
//  Created by Dias Manap on 18.10.2022.
//

import SwiftUI

struct SettingsTabView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var isShowingLogoutAlert = false
    
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
        .toolbar { logoutToolBarItem }
        .alert("Logout", isPresented: $isShowingLogoutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Confirm", role: .destructive) {
                authViewModel.logout()
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
}

extension SettingsTabView {
    var logoutToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                isShowingLogoutAlert = true
            } label: {
                Image(systemName: "person.crop.circle.badge.xmark")
                .font(.system(size: 17, weight: .semibold))
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
