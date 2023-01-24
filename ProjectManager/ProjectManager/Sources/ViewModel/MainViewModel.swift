//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

final class MainViewModel: ViewModelDelegate {
    private var todoList: [Project] = [] {
        didSet {
            todoHandler?(todoList)
        }
    }
    private var doingList: [Project] = [] {
        didSet {
            doingHandler?(doingList)
        }
    }
    private var doneList: [Project] = [] {
        didSet {
            doneHandler?(doneList)
        }
    }

    var todoHandler: (([Project]) -> Void)?
    var doingHandler: (([Project]) -> Void)?
    var doneHandler: (([Project]) -> Void)?

    func deleteProject(with project: Project) {
        switch project.state {
        case .todo:
            todoList = todoList.filter { $0.id != project.id }
        case .doing:
            doingList = doingList.filter { $0.id != project.id }
        case .done:
            doneList = doneList.filter { $0.id != project.id }
        }
    }
    
    private func changeDateString(from date: Date) -> String {
        date.description
    }
}

extension MainViewModel {
    func addProject(_ project: Project?) {
        guard let project = project else { return }

        todoList.append(project)
    }
    
    func updateProject(_ project: Project?) {
        guard let project = project else { return }
        
        switch project.state {
        case .todo:
            changeProject(in: &todoList, to: project)
        case .doing:
            changeProject(in: &doingList, to: project)
        case .done:
            changeProject(in: &doneList, to: project)
        }
    }
    
    private func changeProject(in list: inout [Project], to project: Project) {
        guard let index = list.firstIndex(where: { $0.id == project.id }) else { return }
        list[index] = project
    }
}
