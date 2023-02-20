//
//  CollectionType+Extension.swift
//  SpeedRead
//
//  Created by Dias Manap on 12.02.2023.
//

import SwiftUI

extension Collection {
    func indexEnumerate() -> Array<(Indices.Iterator.Element, Iterator.Element)> {
        return Array(zip(indices, self))
    }
}
