//
//  Article.swift
//  SpeedRead
//
//  Created by Dias Manap on 30.01.2023.
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let subtitle: String?
    let topics: [String]?
    let iconLink: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case topics
        case iconLink
        case content
    }
    
    static var example: Article {
        Article(id: "1", title: "Life with Speed Read", subtitle: "Not a single read", topics: ["Speed", "Comprehension"], iconLink: "data:image/png;base64,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", content: """
                **The Reading Process**
                The first step is for the eyes to look at a word. This “fixation” on every word takes around 0.25 seconds.

                Next, you start moving your eyes to the following word. It takes 0.1 seconds for the brain to move from one word to the next. This is called “saccade.”

                Usually, you take in 4-5 words in your head, or a sentence, at once. After all the fixations and saccades, the brain goes over the entire phrase again in order to process the meaning. This takes around half a second.

                All in all, this means average people read 200 to 300 words in a minute.

                **Speeding up the Process**
                The concept of speed reading is to speed up this process by at least 5 times. Since the saccade period cannot be shortened any further, speed reading emphasizes quicker fixations.

                To accomplish this, scientists recommend that the reader skips the sub-vocalization: when the readers actually say the word in their mind, even when reading silently.

                Basically, speed reading is the technique of only seeing the words instead of speaking them silently.

                Do not confuse this with skimming. When a reader skims through a text, they skip the parts that their brain considers to be unnecessary. You may skip important information in this process, and skimming does not allow the brain to retain what has been read.
            """)
    }
}
