//
//  ReadingPageView.swift
//  SpeedRead
//
//  Created by Dias Manap on 07.11.2022.
//

import SwiftUI

let textSample = "    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n\n     Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? \n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n\n Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? \n\n "

struct ReadingPageView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @StateObject var settingsViewModel = SettingsViewModel()
    
    
    let words = textSample.components(separatedBy: .whitespaces)
    @State var cur = 1
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    // every: 60 / wpm
    
    let reading: Reading
    
    var body: some View {
        VStack {
            if settingsViewModel.readingMode == .highlight {
                ScrollView(showsIndicators: false) {
                    Text(words[...(cur-1)].joined(separator: " "))
                        .foregroundColor(settingsViewModel.selectedTheme.textColor.opacity(1 - (settingsViewModel.constrast / 100)))
                    +
                    Text(" \(words[cur]) ")
                        .foregroundColor(settingsViewModel.selectedTheme.textColor)
                    +
                    Text(words[(cur+1)...].joined(separator: " "))
                        .foregroundColor(settingsViewModel.selectedTheme.textColor.opacity(1 - (settingsViewModel.constrast / 100)))
                }
                .font(.system(size: settingsViewModel.fontSize, weight: .regular))
                .lineSpacing(5)
                .multilineTextAlignment(.leading)
                .onReceive(timer) { _ in
                    cur += 1
                }
                .padding(.horizontal, 25)
                .padding(.top, 10)
            } else {
                Text(words[cur])
                    .font(.system(size: settingsViewModel.fontSize, weight: .regular))
                    .foregroundColor(settingsViewModel.selectedTheme.textColor)
                    .onReceive(timer) { _ in
                        cur += 1
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(settingsViewModel.selectedTheme.backgroundColor)
        .navigationTitle(reading.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationViewModel.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                }

            }
             
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    settingsViewModel.presentSettings = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
        .sheet(isPresented: $settingsViewModel.presentSettings) {
            ZStack {
                settingsViewModel.selectedTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                switch settingsViewModel.selectedSheet {
                case .reading:
                    SettingsSheetView()
                        .environmentObject(settingsViewModel)
                        .presentationDetents([.fraction(0.8)])
                case .font:
                    FontsSheetView()
                        .environmentObject(settingsViewModel)
                        .presentationDetents([.fraction(0.8)])
                }
            }
            .foregroundColor(settingsViewModel.selectedTheme.textColor)
        }
    }
}

struct ReadingPageView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingPageView(reading: Reading.example)
    }
}
