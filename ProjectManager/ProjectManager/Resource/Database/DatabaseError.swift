//
//  DatabaseError.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/07.
//

import Foundation

enum DatabaseError: LocalizedError {
    case invalidFetchRequest
    case failedContextSave(error: Error)

    var errorDescription: String? {
        switch self {
        case .invalidFetchRequest:
            return NSLocalizedString("Invalid Fetch Request", comment: "Fetch Error")
        case .failedContextSave:
            return NSLocalizedString("Failed To Save Context", comment: "Context Save Error")
        }
    }
}
