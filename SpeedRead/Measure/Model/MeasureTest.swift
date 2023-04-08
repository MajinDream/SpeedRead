//
//  MeasureType.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import Foundation

struct MeasureTest: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let subtitle: String?
    let iconLink: String?
    let content: String?
    var questions: [Question]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case iconLink
        case content
        case questions
    }
    
    static let example = MeasureTest(
        id: "test",
        title: "Sherlock the Holmes",
        subtitle: "Conan Arthur Doile",
        iconLink: "https://static.wikia.nocookie.net/thesherlock/images/e/ea/Sherlockholmes1.png/revision/latest?cb=20131219183049",
        content: "Detection is, or ought to be, an exact science and should be treated in the same cold and unemotional manner. You have attempted to tinge it [A Study in Scarlet] with romanticism, which produces much the same effect as if you worked a love-story or an elopement into the fifth proposition of Euclid. ... Some facts should be suppressed, or, at least, a just sense of proportion should be observed in treating them. The only point in the case which deserved mention was the curious analytical reasoning from effects to causes, by which I succeeded in unravelling. Detection is, or ought to be, an exact science and should be treated in the same cold and unemotional manner. You have attempted to tinge it [A Study in Scarlet] with romanticism, which produces much the same effect as if you worked a love-story or an elopement into the fifth proposition of Euclid. ... Some facts should be suppressed, or, at least, a just sense of proportion should be observed in treating them. The only point in the case which deserved mention was the curious analytical reasoning from effects to causes, by which I succeeded in unravelling it. Detection is, or ought to be, an exact science and should be treated in the same cold and unemotional manner. You have attempted to tinge it [A Study in Scarlet] with romanticism, which produces much the same effect as if you worked a love-story or an elopement into the fifth proposition of Euclid. ... Some facts should be suppressed, or, at least, a just sense of proportion should be observed in treating them. The only point in the case which deserved mention was the curious analytical reasoning from effects to causes, by which I succeeded in unravelling it. Detection is, or ought to be, an exact science and should be treated in the same cold and unemotional manner. You have attempted to tinge it [A Study in Scarlet] with romanticism, which produces much the same effect as if you worked a love-story or an elopement into the fifth proposition of Euclid. ... Some facts should be suppressed, or, at least, a just sense of proportion should be observed in treating them. The only point in the case which deserved mention was the curious analytical reasoning from effects to causes, by which I succeeded in unravelling it.",
        questions: [Question.example, Question.example2, Question.example3, Question.example4]
    )

}

struct Question: Codable, Hashable, Identifiable {
    let id: String
    let question: String?
    let answers: [String]?
    let correctAnswer: Int?
    let paragraphId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case question = "content"
        case answers
        case correctAnswer
        case paragraphId
    }
    
    static let example = Question(
        id: "test",
        question: "What is life?",
        answers: [
            "Baby don't",
            "Baby don't hurt",
            "Baby don't hurt me",
            "Baby don't hurt me no more"
        ],
        correctAnswer: 3,
        paragraphId: nil
    )
    
    static let example2 = Question(
        id: "test2",
        question: "Who is life?",
        answers: [
            "No",
            "Yes",
            "Maybe",
            "Baby"
        ],
        correctAnswer: 1,
        paragraphId: nil
    )
    
    static let example3 = Question(
        id: "test3",
        question: "When is life?",
        answers: [
            "Past",
            "Future",
            "Present",
            "Future Past"
        ],
        correctAnswer: 2,
        paragraphId: nil
    )
    
    static let example4 = Question(
        id: "test4",
        question: "Why is life?",
        answers: [
            "No",
            "Yes",
            "Comprehension",
            "Test"
        ],
        correctAnswer: 0,
        paragraphId: nil
    )
}
