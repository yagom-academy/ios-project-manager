//
//  TodoError.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/11.
//

import Foundation

enum TodoError: Error {
    case emptyTitle
    case initializingFailed
}

extension TodoError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return NSLocalizedString("Title is Empty.", comment: "emptyTitle")
        case .initializingFailed:
            return NSLocalizedString("Initializing Failed.", comment: "initializingFailed")
        }
    }
}
