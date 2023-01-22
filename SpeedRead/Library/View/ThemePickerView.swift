//
//  ThemePickerView.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import SwiftUI

enum ThemeType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case darkGray
    case lightGray
    case white
    case black
    
    var backgroundColor: Color {
        switch self {
        case .darkGray:     return Color("darkGray")
        case .lightGray:    return Color("lightGray")
        case .white:        return Color.white
        case .black:        return Color.black
        }
    }

    var textColor: Color {
        switch self {
        case .darkGray:     return Color("lightGray")
        case .lightGray:    return Color("darkGray")
        case .white:        return Color.black
        case .black:        return Color.white
        }
    }
}

struct ThemePickerView: View {
    @Binding var selectedTheme: ThemeType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Theme")
                .font(.system(size: 22, weight: .medium))
            
            HStack(spacing: 20) {
                ForEach(ThemeType.allCases) { theme in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .aspectRatio(1.0, contentMode: .fit)
                            .foregroundColor(theme.backgroundColor)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedTheme == theme ? Color.accentColor : Color.clear, lineWidth: 2.5)
                                    .shadow(radius: 5)
                            }
                        
                        Text("Aa")
                            .font(.system(size: 36, weight: .regular))
                            .foregroundColor(theme.textColor)
                    }
                    .onTapGesture {
                        selectedTheme = theme
                    }
                }
            }
            .shadow(radius: 4, y: 4)
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView(selectedTheme: .constant(.darkGray))
    }
}
