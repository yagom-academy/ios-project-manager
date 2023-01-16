//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

class MainViewModel {
    
    let processTitles: [String] = [Process.todo.title, Process.doing.title, Process.done.title]
    var datas: [[Project]] = [[], [], []] {
        didSet {
            updateDatas(datas, datasCount(datas))
        }
    }

    var datasCount = { (datas: [[Project]]) -> [String] in
        return datas.map { String($0.count) }
    }
    
    var updateDatas: ([[Project]], [String]) -> Void = { _, _ in }
    
    var newProject: Project {
        return Project(title: "", description: "", date: Date(), uuid: UUID())
    }
    
    func registerProject(_ project: Project, in process: Process) {
        datas[process.index].append(project)
    }
    
    func editProject(_ project: Project, in process: Process) {
        datas[process.index].enumerated().forEach { index, data in
            guard data.uuid == project.uuid else { return }
            datas[process.index][index] = project
        }
    }
    
    func deleteData(_ project: Project, in process: Process) {
        datas[process.index].enumerated().forEach { index, data in
            guard data.uuid == project.uuid else { return }
            datas[process.index].remove(at: index)
        }
    }
    
    func moveData(_ project: Project, from currentProcess: Process, to process: Process) {
        deleteData(project, in: currentProcess)
        registerProject(project, in: process)
    }
}
