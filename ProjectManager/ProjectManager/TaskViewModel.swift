//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/29.
//

import Foundation

final class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = [
        Task(title: "책상정리", description: "집중이 안돼요", date: Date(), state: .todo),
        Task(title: "라자냐", description: """
            재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요
                        재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요재료는 뭘까요
            """, date: Date(), state: .doing),
        Task(title: "일기쓰기", description: "매일 씁시다", date: Date(), state: .doing),
        Task(title: "설거지하기", description: "뽀드득", date: Date(), state: .done)
    ]

    func addTask(task: Task) {
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
}
