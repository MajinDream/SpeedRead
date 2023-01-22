//
//  Exercise.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.01.2023.
//

import SwiftUI

enum Exercise: String, CaseIterable, Identifiable {
    case schulte
    case pairMatch
    case mnemonics

    var id: String { return self.rawValue }
    
    var title: String {
        switch self {
        case .schulte: return "Schulte Table"
        case .pairMatch: return "Pair Matching"
        case .mnemonics: return "Mnemonics"
        }
    }

    var subtitle: String {
        switch self {
        case .schulte: return "Develop peripheral vision"
        case .pairMatch: return "Increase attention and memory"
        case .mnemonics: return "Improve retention"
        }
    }

    var imageLink: String {
        switch self {
        case .schulte: return "https://images-platform.99static.com//KqNMbKVaRIOWgnnNNH4qUJeuwkE=/120x2108:880x2868/fit-in/500x500/99designs-contests-attachments/109/109763/attachment_109763032"
        case .pairMatch: return "https://images-platform.99static.com/2HkCqmmlW0Ubvima63vbLDgmjDU=/0x0:1388x1388/500x500/top/smart/99designs-contests-attachments/124/124886/attachment_124886640"
        case .mnemonics: return "https://thumbs.dreamstime.com/b/memory-linear-icon-modern-outline-logo-concept-white-background-hardware-collection-suitable-use-web-apps-mobile-133521052.jpg"
        }
    }

    @ViewBuilder
    func getExerciseView() -> some View {
        switch self {
        case .schulte: SchulteView()
        case .pairMatch: PairMatchView()
        case .mnemonics: MnemonicsView()
        }
    }
}
