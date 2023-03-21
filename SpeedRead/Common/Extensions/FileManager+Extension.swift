//
//  FileManager+Extension.swift
//  SpeedRead
//
//  Created by Dias Manap on 26.02.2023.
//

import Foundation

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}
