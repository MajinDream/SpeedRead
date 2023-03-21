//
//  SettingsScrollView.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import SwiftUI

enum SettingsSliderType: String {
    case speed = "Speed"
    case length = "Chunk Length"
    case contrast = "Contrast"
    case fontSize = "Font Size"
    
    var name: String {
        self.rawValue
    }
    
    var unit: String {
        switch self {
        case .speed:    return "words per min"
        case .length:   return "characters"
        case .contrast: return "%"
        case .fontSize: return "px"
        }
    }
    
    var valueRange: ClosedRange<Double> {
        switch self {
        case .speed:    return 1...500
        case .length:   return 1...50
        case .contrast: return 0...100
        case .fontSize: return 10...30
        }
    }
}


struct SettingsSliderView: View {
    let type: SettingsSliderType
    @Binding var value: Double
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .lastTextBaseline) {
                Text(type.name)
                    .font(.system(size: 22, weight: .medium))
                Spacer()
                Text((value.rounded().formatted()))
                    .font(.system(size: 22, weight: .medium))
                Text(type.unit)
                    .font(.system(size: 14, weight: .medium))
            }
            
            Slider(value: $value, in: type.valueRange)
                .onAppear {
                    let thumbImage = UIImage(systemName: "circle.fill")
                    UISlider.appearance().setThumbImage(thumbImage, for: .normal)
                }
        }
    }
}

struct SettingsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSliderView(type: .speed, value: .constant(220))
    }
}
