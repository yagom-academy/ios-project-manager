//
//  DatabaseError.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import Foundation

enum DatabaseError: LocalizedError {
    case createError
    case fetchedError
    case updatedError
    case deletedError

    var errorDescription: String? {
        switch self {
        case .createError:
            return "생성에 실패하였습니다."
        case .fetchedError:
            return "불러오는데 실패하였습니다."
        case .updatedError:
            return "수정에 실패했습니다."
        case .deletedError:
            return "삭제에 실패했습니다."
        }
    }
}
