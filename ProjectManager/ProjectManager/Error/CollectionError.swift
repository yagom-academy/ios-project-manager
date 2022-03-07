//
//  CollectionError.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/03.
//

import Foundation

enum CollectionError: Error {
    case indexOutOfRange
}

extension CollectionError: LocalizedError {
    var description: String {
        switch self {
        case .indexOutOfRange:
            return "index out of range"
        }
    }
}
