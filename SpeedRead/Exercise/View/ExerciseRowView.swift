//
//  ExerciseRowView.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

import SwiftUI

struct ExerciseRowView: View {
    let exercise: Exercise
    
    var body: some View {
        NavigationLink(value: exercise) {
            HStack(spacing: 14) {
                AsyncImageView(iconLink: exercise.imageLink)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                    .padding([.leading, .vertical], 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(exercise.title)
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 4)
                    
                    
                    Text(exercise.subtitle)
                        .foregroundColor(.primary.opacity(0.5))
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 4)
                }
                .padding(.vertical, 13)
                .padding(.trailing, 20)
                
                Spacer()
            }
            .background(Color("secondary"))
            .cornerRadius(12)
        }
    }
}

struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRowView(exercise: .schulte)
    }
}
