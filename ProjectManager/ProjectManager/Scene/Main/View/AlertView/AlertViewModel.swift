//
//  AlertViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

class AlertViewModel {
    
    // MARK: - Properties

    private let mainViewModel = MainViewModel.shared
    
    // MARK: - Functions

    func searchContent(from index: Int, of type: ProjectType) -> ToDoItem {
        switch type {
        case .todo:
            return mainViewModel.todoContent.get(index: index) ?? ToDoItem()
        case .doing:
            return mainViewModel.doingContent.get(index: index) ?? ToDoItem()
        case .done:
            return mainViewModel.doneContent.get(index: index) ?? ToDoItem()
        }
    }
    
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
    
    func delete(from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            mainViewModel.todoContent.remove(at: index)
        case .doing:
            mainViewModel.doingContent.remove(at: index)
        case .done:
            mainViewModel.doneContent.remove(at: index)
        }
    }
    
    func move(project: ProjectType, in index: IndexPath, to anotherProject: ProjectType) {
        let movingContent = searchContent(from: index.row, of: project)
        
        append(new: movingContent, to: anotherProject)
        delete(from: index.row, of: project)
    }
}
