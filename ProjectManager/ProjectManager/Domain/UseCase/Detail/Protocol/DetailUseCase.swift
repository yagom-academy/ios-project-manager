//
//  DetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

protocol DetailUseCase {
    
    func isValidateDescription(text: String) -> Bool
    func isValidateDeadline(date: Date) -> Bool
}
