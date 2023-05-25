//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import Foundation

final class ListViewModel {
    var todoList: Observable<[ProjectModel]> = Observable([])
    var doingList: Observable<[ProjectModel]> = Observable([])
    var doneList: Observable<[ProjectModel]> = Observable([])

    func configureCell(to cell: TableViewCell, with data: ProjectModel) {
        cell.configureContent(with: data)
    }
    
    func fetchList(with state: State) -> [ProjectModel] {
        switch state {
        case .todo:
            return todoList.value
        case .doing:
            return doingList.value
        case .done:
            return doneList.value
        }
    }
    
    func fetchProject(with state: State, index: Int) -> ProjectModel {
        switch state {
        case .todo:
            return todoList.value[index]
        case .doing:
            return doingList.value[index]
        case .done:
            return doneList.value[index]
        }
    }
    
    func countProject(in state: State) -> Int {
        return fetchList(with: state).count
    }

    func addProject(new: ProjectModel) {
        todoList.value.append(new)
    }
    
    func deleteProject(in state: State, at index: Int) {
        switch state {
        case .todo:
            todoList.value.remove(at: index)
        case .doing:
            doingList.value.remove(at: index)
        case .done:
            doneList.value.remove(at: index)
        }
    }
}

