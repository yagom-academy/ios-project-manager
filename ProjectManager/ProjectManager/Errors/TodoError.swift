//
//  TodoError.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/28.
//

import Foundation
enum TodoError: Error {
    case saveError
    case deleteError
    case unknownItem
    case backUpError
    case historySyncError
}

extension TodoError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .saveError:
            return "저장 중 오류가 발생했습니다."
        case .deleteError:
            return "삭제 중 오류가 발생했습니다."
        case .unknownItem:
            return "해당 컨텐츠를 찾지 못했습니다."
        case .backUpError:
            return "데이터를 읽어오지 못했습니다."
        case .historySyncError:
            return "History와 동기화하지 못했습니다."
        }
    }
}
