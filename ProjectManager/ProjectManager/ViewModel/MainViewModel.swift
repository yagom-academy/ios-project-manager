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
}
