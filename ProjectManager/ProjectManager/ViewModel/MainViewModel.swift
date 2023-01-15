//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

class MainViewModel {
    
    let processTitles: [String] = [Process.todo.title, Process.doing.title, Process.done.title]
    var todoData: [Project] = [] {
        didSet {
            updateData(.todo, todoData, dataCount(todoData))
        }
    }
    var doingData: [Project] = [] {
        didSet {
            updateData(.doing, doingData, dataCount(doingData))
        }
    }
    var doneData: [Project] = [] {
        didSet {
            updateData(.done, doneData, dataCount(doneData))
        }
    }
    
    var datas: [[Project]] {
        return [todoData, doingData, doneData]
    }
    
    var dataCount = { (datas: [Project]) -> String in
        return String(datas.count)
    }
    
    var updateData: (Process, [Project], String) -> Void = { _, _, _ in }
    
    var newProject: Project {
        return Project(title: "", description: "", date: Date(), uuid: UUID())
    }
    
    func registerProject(_ project: Project, in process: Process) {
        switch process {
        case .todo:
            todoData.append(project)
        case .doing:
            doingData.append(project)
        case .done:
            doneData.append(project)
        }
    }
    
    func editProject(_ project: Project, in process: Process) {
        var index = 0
        switch process {
        case .todo:
            todoData.enumerated().forEach { offset, data in
                guard data.uuid == project.uuid else { return }
                index = offset
            }
            todoData[index] = project
        case .doing:
            doingData.enumerated().forEach { offset, data in
                guard data.uuid == project.uuid else { return }
                index = offset
            }
            doingData[index] = project
        case .done:
            doneData.enumerated().forEach { offset, data in
                guard data.uuid == project.uuid else { return }
                index = offset
            }
            doneData[index] = project
        }
    }
}
