//
//  ScrollTextTest.swift
//  SpeedRead
//
//  Created by Dias Manap on 15.11.2022.
//

import SwiftUI

struct ScrollTextTest: View {
    var body: some View {
        ZStack {
            ZStack() {
                Text("alpha")
                    .foregroundColor(.primary.opacity(0.5))
                    .offset(x: -50)
                Text("in")
                Text("words[next]")
                    .foregroundColor(.primary.opacity(0.5))
                    .offset(x: CGFloat("words[next]".count * 6))
            }
            .font(.system(size: 18, weight: .regular))
            
            Rectangle()
                .frame(width: 1, height: 40)
        }
    }
}

struct ScrollTextTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTextTest()
    }
}
