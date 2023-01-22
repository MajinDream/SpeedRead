//
//  FontsSheetView.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import SwiftUI

struct FontsSheetView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        withAnimation {
                            settingsViewModel.selectedSheet = .reading
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                }
                
                Text("Fonts")
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Color("primary"))
            .padding(26)
            
            
            VStack(alignment: .leading) {
                SettingsSliderView(type: .fontSize, value: $settingsViewModel.fontSize)
                
                Divider()
                
                ForEach(Fonts.allCases) { font in
                        
                        HStack {
                            Text(font.rawValue)
                                .foregroundColor(settingsViewModel.selectedFont == font ? .accentColor : settingsViewModel.selectedTheme.textColor)
                            if settingsViewModel.selectedFont == font {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.vertical, 16)
                        .onTapGesture {
                            settingsViewModel.selectedFont = font
                        }
                    
                    Divider()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct FontsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        FontsSheetView()
            .environmentObject(SettingsViewModel())
    }
}
