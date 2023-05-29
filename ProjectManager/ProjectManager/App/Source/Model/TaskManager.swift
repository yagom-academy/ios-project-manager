//
//  TaskManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation
import Combine

final class TaskManager {
    static let shared = TaskManager()
    private let realmManager = RealmManager()
    
    @Published private var taskList: [MyTask] = []
    
    private init() {
        fetch()
    }
    
    func taskListPublisher() -> AnyPublisher<[MyTask], Never> {
        return $taskList.eraseToAnyPublisher()
    }
    
    func fetch() {
        guard let realmList = realmManager.readAll(type: RealmTask.self) else { return }
        
        taskList = realmList.map { MyTask($0) }
    }
    
    func create(_ task: MyTask) {
        taskList.append(task)
        
        let realmTask = RealmTask(task)
        realmManager.create(realmTask)
    }
    
    func update(_ task: MyTask) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        
        taskList[safe: index] = task
        
        let realmTask = RealmTask(task)
        realmManager.update(realmTask)
    }
    
    func delete(_ task: MyTask) {
        taskList.removeAll { $0.id == task.id }
        
        let realmTask = RealmTask(task)
        realmManager.delete(realmTask)
    }
}
