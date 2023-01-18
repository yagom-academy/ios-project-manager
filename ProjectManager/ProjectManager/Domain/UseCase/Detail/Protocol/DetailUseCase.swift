//
//  DetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

protocol DetailUseCase {
    
    var state: State { get }
    func fetchText(of item: ProjectTextItem) -> String
    func fetchDeadline() -> Date
    func fetchIdentifier() -> UUID
    func isValidateDescription(text: String) -> Bool
    func isValidateDeadline(date: Date) -> Bool
}
