//
//  TaskError.swift
//  ProjectManager
//
//  Created by sookim on 2021/07/27.
//

import Foundation

enum TaskError: Error {
    case encodingFailure
    case decodingFailure
}

extension TaskError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .encodingFailure:
            return "인코딩 실패🚨"
        case .decodingFailure:
            return "디코딩 실패🚨"
        }
    }
}
