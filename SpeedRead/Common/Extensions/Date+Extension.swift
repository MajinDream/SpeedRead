//
//  Date+Extension.swift
//  SpeedRead
//
//  Created by Dias Manap on 06.04.2023.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
