//
//  Error.swift
//  ProjectManager
//
//  Created by minsson on 2022/10/06.
//

enum LogicError: Error {
    case replaceOriginalTask
    case deleteOriginalTask
    case unknown
    
    var description: String {
        switch self {
        case .replaceOriginalTask:
            return "수정사항 반영"
        case .deleteOriginalTask:
            return "Task 삭제"
        case .unknown:
            return "알 수 없는"
        }
    }
}
