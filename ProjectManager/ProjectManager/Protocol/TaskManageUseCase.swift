//
//  TaskManageUseCase.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/21.
//

import Foundation

protocol TaskManageUseCase {
    func checkValidInput(title: String, description: String) -> Result<Bool, TextError>
    func checkValidTextLength(with range: NSRange, length: Int) -> Bool
}
