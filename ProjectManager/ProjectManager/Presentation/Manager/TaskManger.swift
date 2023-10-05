//
//  TaskManger.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import SwiftUI

@MainActor
final class TaskManager: ObservableObject {
    private let taskUseCases: TaskUseCases
    
    @Published var tasks: [Task]
    
    var todos: [Task] {
        return tasks.filter { $0.state == .todo }
    }
    
    var doings: [Task] {
        return tasks.filter { $0.state == .doing }
    }
    
    var dones: [Task] {
        return tasks.filter { $0.state == .done }
    }
    
    init(taskUseCases: TaskUseCases) {
        self.taskUseCases = taskUseCases
        self.tasks = []
        _Concurrency.Task {                        
            self.tasks = await taskUseCases.initialFetch()
        }
    }
    
    func registerFetch() {
        _Concurrency.Task {
            self.tasks = await taskUseCases.registerFetch()
        }
    }

    func create(_ task: Task) {
        taskUseCases.createTask(task)
        fetchLocalTasks()
    }
    
    func update(newTask: Task) {
        taskUseCases.updateTask(id: newTask.id, new: newTask)
        fetchLocalTasks()
    }
    
    func move(_ task: Task, to state: TaskState) {
        taskUseCases.moveTask(task: task, to: state)
        fetchLocalTasks()
    }

    func delete(_ task: Task) {
        taskUseCases.deleteTask(task)
        fetchLocalTasks()
    }

    private func fetchLocalTasks() {
        self.tasks = taskUseCases.fetchLocalTasks()
    }
}

extension TaskManager {
    convenience init(tasks: [Task]) {
        self.init(taskUseCases: TaskUseCases(
                localRepository: RealTaskLocalRepository(),
                remoteRepository: RealTaskRemoteRepository(),
                userRepository: RealUserLocalRepository())
        )
        self.tasks = tasks
    }
    
    static let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
    static let mock = TaskManager(
        tasks: [
            Task(title: "탁구하기🏓", content: "삶이 있는 한 희망은 있다", date: yesterday, state: .todo),
            Task(title: "선인장 물 주기🌵", content: "산다는것 그것은 치열한 전투이다", date: .now, state: .todo),
            Task(title: "코딩하기💻", content: "먼저핀꽃은 먼저진다 남보다 먼저 공을 세우려고 조급히 서둘것이 아니다", date: yesterday, state: .todo),
            Task(title: "빨래하기👚", content: "행복의 문이 하나 닫히면 다른 문이 열린다 그러나 우리는 종종 닫힌 문을 멍하니 바라보다가 우리를 향해 열린 문을 보지 못하게 된다", date: .now, state: .doing),
            Task(title: "프로젝트 이름 정하기", content: "먼저 자신을 비웃어라. 다른 사람이 당신을 비웃기 전에", date: yesterday, state: .doing),
            Task(title: "운동하기🏋️‍♀️", content: "절대 어제를 후회하지 마라. 인생은 오늘의 내 안에 있고 내일은 스스로 만드는것이다.", date: yesterday, state: .done),
            Task(title: "라자냐 재료구입🥘", content: "좋은 성과를 얻으려면 한 걸음 한 걸음이 힘차고 충실하지 않으면 안 된다", date: .now, state: .done),
            Task(title: "오늘의 할 일 찾기🔎", content: "고통이 남기고 간 뒤를 보라! 고난이 지나면 반드시 기쁨이 스며든다", date: yesterday, state: .done)
        ]
    )
}
