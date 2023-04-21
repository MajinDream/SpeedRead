//
//  MnemonicsViewModel.swift
//  SpeedRead
//
//  Created by Dias Manap on 24.01.2023.
//

import Foundation

final class MnemonicsViewModel: ObservableObject {
    @Published var chosenWord = ""
    @Published var enteredWord = ""
    @Published var currentIndex = 0
    @Published var isWon = false
    @Published var isLost = false
    @Published var wordList = [String]()

    init() {
        fetchWordList()
        chooseWord()
    }
    
    private func fetchWordList() {
        wordList = ["dimple", "embark", "jovial", "flurry", "glisten", "hurtle", "knotty", "lagoon", "mumble", "nimble", "oasis", "paddle", "quaint", "ravage", "sketch", "tickle", "upbeat", "vortex", "wobble", "yonder", "zephyr", "acuity", "blithe", "clique", "dulcet", "epoch", "fervor", "gossam", "happen", "incite", "jockey", "kinema", "lucent", "morsel", "nuzzle", "offing", "peruse", "quench", "raunch", "scruff", "tangle", "uplift", "vandal", "whence", "yapock", "zinger", "analog", "blench", "cruxes", "drivel", "elicit", "flaunt", "gadget", "hearth", "ingest", "joggle", "kindle", "larder", "mizzle", "novice", "omened", "pebble", "quiche", "rancor", "stifle", "turgid", "unsung", "viable", "wicker", "youths", "zodiac", "abound", "brogue", "cortex", "dazzle", "esteem", "fondly", "gander", "herald", "invent", "jagged", "keenly", "longer", "mantra", "nudity", "omelet", "pursue", "quorum", "rafter", "saddle", "trifle", "umbral", "votive", "wombat", "yippie", "zither"]
    }

    func chooseWord() {
        chosenWord = wordList.randomElement() ?? "Test"
    }

    func didTapComplete() {
        if chosenWord.uppercased() == enteredWord.uppercased() {
            isWon = true
        } else {
            isLost = true
        }
        enteredWord = ""
        chooseWord()
    }

    func getLetter(at index: Int) -> String {
        guard self.enteredWord.count > index else {
            return ""
        }
        return self.enteredWord[index]
    }
    
    func limitText() {
        if enteredWord.count > chosenWord.count {
            enteredWord = String(enteredWord.prefix(chosenWord.count))
        }
    }
}
