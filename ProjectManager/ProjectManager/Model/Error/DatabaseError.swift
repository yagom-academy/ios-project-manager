//
//  DatabaseError.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import Foundation

enum DatabaseError: LocalizedError {
    case databaseConfigureError
    case createError
    case fetchedError
    case updatedError
    case deletedError

    var errorDescription: String? {
        switch self {
        case .databaseConfigureError:
            return "데이터베이스 생성에 실패하였습니다"
        case .createError:
            return "생성에 실패했습니다."
        case .fetchedError:
            return "불러오는데 실패했습니다."
        case .updatedError:
            return "수정에 실패했습니다."
        case .deletedError:
            return "삭제에 실패했습니다."
        }
    }
}
