//
//  ProjectDetailViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/23.
//

import Foundation

class ProjectDetailViewModel {
    
    let mainViewModel = MainViewModel.shared
    
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
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            mainViewModel.todoContent[index] = item
        case .doing:
            mainViewModel.doingContent[index] = item
        case .done:
            mainViewModel.doneContent[index] = item
        }
    }
}
