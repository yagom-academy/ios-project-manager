//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import Foundation

class TaskListViewModel {
    var tasks: [Task] = []
    
    var todoTasks: [Task] = []
    var doingTasks: [Task] = []
    var doneTasks: [Task] = []
    
    let sampleData = SampleDummyData()
    
    init() {
        setSampleData(sampleData.sampleDummy)
        sortOutTasks()
    }
}

extension TaskListViewModel {
    func setSampleData(_ sampleData: [Task]) {
        tasks = sampleData
    }
    
    func sortOutTasks() {
        todoTasks = tasks.filter { ($0).status == .todo }
        doingTasks = tasks.filter { ($0).status == .doing }
        doneTasks = tasks.filter { ($0).status == .done }
    }
    
}
