//
//  DetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

protocol DetailUseCase {
    
    var state: State { get }
    func fetchTitleText() -> String
    func fetchDescriptionText() -> String
    func fetchDeadline() -> Date
    func fetchIdentifier() -> UUID
    func isValidateDescription(text: String) -> Bool
    func isValidateDeadline(date: Date) -> Bool
}
