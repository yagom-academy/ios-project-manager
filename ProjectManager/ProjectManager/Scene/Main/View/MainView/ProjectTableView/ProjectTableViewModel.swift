//
//  ProjectTableViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

class ProjectTableViewModel {
    
    // MARK: - Properties

    private let mainViewModel = MainViewModel.shared
    
    // MARK: - Functions

    func count(of type: ProjectType) -> Int {
        switch type {
        case .todo:
            return mainViewModel.todoContent.count
        case .doing:
            return mainViewModel.doingContent.count
        case .done:
            return mainViewModel.doneContent.count
        }
    }
    
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
}
