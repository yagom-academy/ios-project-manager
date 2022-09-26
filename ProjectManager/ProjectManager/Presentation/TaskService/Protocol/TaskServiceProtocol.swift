//
//  File.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/22.
//

import UIKit

protocol TaskServiceProtocol {
    func viewDidLoad()
    func addButtonDidTap()
    func cellDidTap(index: Int, state: TaskState)
    func doneButtonDidTap(viewModel: TaskViewModel)
    func moveTask(viewModel: TaskViewModel, currentState: TaskState, changedState: [TaskState]) -> [UIAlertAction]
    func deleteButtonDidTap(index: Int, state: TaskState)
}
