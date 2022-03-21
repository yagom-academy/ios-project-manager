//
//  DefaultTaskManageUseCase.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/21.
//

import Foundation

final class DefaultTaskManageUseCase: TaskManageUseCase {
    func checkValidInput(title: String, description: String) -> Result<Bool, TextError> {
        if title.isEmpty && description.isEmpty {
            return .failure(.invalidTitleAndDescription)
        } else if title.isEmpty {
            return .failure(.invalidTitle)
        } else if description.isEmpty {
            return .failure(.invalidDescription)
        }
        
        return .success(true)
    }
    
    func checkValidTextLength(with range: NSRange, length: Int) -> Bool {
        if range.location == length {
            return false
        }
        if range.length > .zero {
            return true
        }
        
        return range.location < length
    }
}
