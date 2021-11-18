//
//  MockData.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import Foundation

class MockData {
    var tasks: [TLTask] = []

    init() {
        tasks = [
            TLTask(id: UUID(), title: "스크럼하기", message: "어려운 내용,알게된 내용 공유하기", date: Date(), status: .DONE),
            TLTask(id: UUID(), title: "TIL쓰기", message: "자주쓰자..", date: Date(), status: .DOING),
            TLTask(id: UUID(), title: "SwiftUI공부하기", message: "너무 어렵다.", date: Date(), status: .DOING),
            TLTask(id: UUID(), title: "설거지하자", message: "설거지!", date: Date(), status: .TODO)
        ]
    }
}

extension MockData: DataManagerProtocol {
    func addTask(title: String, message: String, date: Date, status: Status) {
        let task = TLTask(title: title, message: message, date: date, status: status)
        tasks.insert(task, at: 0)
    }
    
    func updateTaskList(task: TLTask?, status: Status, title: String, message: String, date: Date) {
        tasks.firstIndex { $0.id == task?.id }.flatMap { tasks[$0] = TLTask(title: title, message: message, date: date, status: status) }
    }
    
    var fetchTask: [TLTask] {
        return tasks
    }
    
    func deleteTask(task: TLTask) {
        tasks.firstIndex { $0.id == task.id }.flatMap { tasks.remove(at: $0) }
    }
}

