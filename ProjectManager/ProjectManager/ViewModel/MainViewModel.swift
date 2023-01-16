//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

final class MainViewModel {
    
    private let processTitles: [String] = Process.allCases.map { process in
        return process.title
    }
    
    private var datas: [[Project]] = [[], [], []] {
        didSet {
            updateDatas(datas, datasCount(datas))
        }
    }
    
    private var datasCount = { (datas: [[Project]]) -> [String] in
        datas.map { String($0.count) }
    }
    
    var newProject: Project {
        return Project(title: "", description: "", date: Date(), uuid: UUID())
    }
    
    var updateDatas: ([[Project]], [String]) -> Void = { _, _ in }
    
    func readTitle(of process: Process) -> String {
        return processTitles[process.index]
    }
    
    func readData(in process: Process) -> [Project] {
        return datas[process.index]
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
