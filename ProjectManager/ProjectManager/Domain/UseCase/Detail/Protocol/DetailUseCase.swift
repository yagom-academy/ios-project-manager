//
//  DetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

protocol DetailUseCase {
    
    func fetchText(of item: ProjectTextItem) -> String
    func fetchDeadline() -> Date
    func validateDescription(text: String) -> Bool
}
