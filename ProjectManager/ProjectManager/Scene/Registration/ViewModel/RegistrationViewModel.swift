//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

final class RegistrationViewModel {

    // MARK: - Singletone

    private let mainViewModel = MainViewModel.shared
    
    // MARK: - Functions

    func append(new item: ToDoItem, to type: ProjectType) {
        switch type {
        case .todo:
            mainViewModel.todoContent.append(item)
        case .doing:
            mainViewModel.doingContent.append(item)
        case .done:
            mainViewModel.doneContent.append(item)
        }
    }
}
