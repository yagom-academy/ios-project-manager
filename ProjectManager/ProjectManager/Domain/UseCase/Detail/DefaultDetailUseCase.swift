//
//  DefaultDetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

final class DefaultDetailUseCase: DetailUseCase {
    
    typealias Number = Constant.Number
    
    func isValidateDescription(text: String) -> Bool {
        return text.count <= Number.descriptionLimit
    }
    
    func isValidateDeadline(date: Date) -> Bool {
        return date.isOverdue == false
    }
}
