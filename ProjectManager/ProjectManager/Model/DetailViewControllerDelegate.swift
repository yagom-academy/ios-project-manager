//
//  DetailViewControllerDelegate.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/15.
//

import Foundation

protocol DetailViewControllerDelegate: AnyObject {
    func addTodo(todoModel: TodoModel)
}
