//
//  Reading.swift
//  SpeedRead
//
//  Created by Dias Manap on 22.10.2022.
//

import Foundation

struct Reading: Codable, Hashable, Identifiable {
    var id: String
    let title: String
    let subtitle: String?
    let author: String
    let type: String?
    let iconLink: String?
    let pagesRead: Int?
    let pagesTotal: Int?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case author
        case type
        case iconLink = "coverImageUrl"
        case pagesRead
        case pagesTotal
        case url
    }
    
    static var example: Reading {
        Reading(
            id: "a",
            title: "Book of Mystery",
            subtitle: "",
            author: "Unknwown Micheal",
            type: "Book",
            iconLink: "https://m.media-amazon.com/images/I/41y2DZeaWlL._AC_SY780_.jpg",
            pagesRead: 120,
            pagesTotal: 500,
            url: "https://www.gutenberg.org/cache/epub/70204/pg70204.txt"
        )
    }
}
