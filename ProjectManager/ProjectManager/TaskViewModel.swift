//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/29.
//

import Foundation

final class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func updateTask(id: UUID, title: String, description: String, date: Date, state: TaskState) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            print("해당 task가 존재하지 않음")
            return
        }
        tasks[index].title = title
        tasks[index].description = description
        tasks[index].date = date
        tasks[index].state = state
    }
    
    func updateTask(id: UUID, state: TaskState) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else {
            print("해당 task가 존재하지 않음")
            return
        }
        tasks[index].state = state
    }
    
    func delete(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            print("Index: \(index)번째 task가 지워짐")
            return
        }
        print("아무 task도 지워지지 않음")
    }
}
