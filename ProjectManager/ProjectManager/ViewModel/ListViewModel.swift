//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import UIKit

final class ListViewModel {
    static var shared = ListViewModel()
    var todoList: Observable<[ProjectModel]> = Observable([ProjectModel(title: "111", description: "111", deadLine: Date().addingTimeInterval(-200000), state: .todo)])
    var doingList: Observable<[ProjectModel]> = Observable([ProjectModel(title: "2222222", description: "2222", deadLine: Date().addingTimeInterval(33333333), state: .doing)])
    var doneList: Observable<[ProjectModel]> = Observable([ProjectModel(title: "33", description: "333333333333333333333333", deadLine: Date(), state: .done)])

    func configureCell(to cell: TableViewCell, with data: ProjectModel) {
        cell.configureContent(with: data)
    }
    
    func configureProject(in viewContorller: DetailProjectViewController, with data: ProjectModel) {
        viewContorller.configureContent(with: data)
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
    
    func updateProject(state: State, id: UUID, title: String, description: String, deadLine: Date) {
        var project: ProjectModel
        
        switch state {
        case .todo:
            if let index = todoList.value.firstIndex(where: { $0.id == id }) {
                project = todoList.value[index]
                project.title = title
                project.description = description
                project.deadLine = deadLine
                todoList.value[index] = project
                print("바뀌고나서 id : \(project.id)")
            }
        case .doing:
            if let index = doingList.value.firstIndex(where: { $0.id == id }) {
                project = doingList.value[index]
                project.title = title
                project.description = description
                project.deadLine = deadLine
                doingList.value[index] = project
            }
        case .done:
            if let index = doneList.value.firstIndex(where: { $0.id == id }) {
                project = doneList.value[index]
                project.title = title
                project.description = description
                project.deadLine = deadLine
                doneList.value[index] = project
            }
        }
    }
    
    func move(project: ProjectModel, to changeState: State, at index: Int) {
        var movedProject = project
        movedProject.state = changeState
        deleteProject(in: project.state, at: index)
        
        switch changeState {
        case .todo:
            todoList.value.append(movedProject)
        case .doing:
            doingList.value.append(movedProject)
        case .done:
            doneList.value.append(movedProject)
        }
    }
}
