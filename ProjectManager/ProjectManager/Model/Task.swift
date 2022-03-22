//
//  Task.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/02.
//

import Foundation

class Task: ObservableObject, Identifiable, Equatable {
    
    let id: String
    @Published var title: String
    @Published var body: String
    @Published var dueDate: Date
    @Published var status: TaskStatus
    
    init(title: String, body: String, dueDate: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.status = .todo
    }
    
    // !!!: 할일 인스턴스 deinit 확인용 코드
    deinit {
        print("🍓 할일 인스턴스 삭제됨!")
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
