//
//  GeneratedTaskError.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/22.
//

import Foundation

enum GeneratedTaskError: LocalizedError {
    case titleEmpty
    case descriptionEmpty
    
    var errorDescription: String? {
        switch self {
        case .titleEmpty:
            return "제목을 입력해주세요"
        case .descriptionEmpty:
            return "설명을 입력해주세요"
        }
    }
}
