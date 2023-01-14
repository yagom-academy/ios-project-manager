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
            update(.todo, todoData)
        }
    }
    var doingData: [Project] = [] {
        didSet {
            update(.doing, doingData)
        }
    }
    var doneData: [Project] = [] {
        didSet {
            update(.done, doneData)
        }
    }
    
    var datas: [[Project]] {
        return [todoData, doingData, doneData]
    }
    
    var update: (Process, [Project]) -> Void = { _, _ in }
    
    func registerProject(_ project : Project, in process : Process) {
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
