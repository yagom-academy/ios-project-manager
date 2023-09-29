//
//  AlertActionCreatable.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/29.
//

import UIKit

protocol AlertActionCreator {
    func createMoveToTodoAction(_ selectedCell: ProjectManager) -> UIAlertAction
    func createMoveToDoingAction(_ selectedCell: ProjectManager) -> UIAlertAction
    func createMoveToDoneAction(_ selectedCell: ProjectManager) -> UIAlertAction
}
