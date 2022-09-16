//
//  TodoError.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/11.
//

import Foundation

enum TodoError: Error, LocalizedError {
    case emptyTitle
    
    var errorDescription: String {
        switch self {
        case .emptyTitle:
            return "Title is Empty."
        }
    }
}
