//
//  TaskManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation
import Combine

final class TaskManager {
    private let realmManager = RealmManager()
    private let firebaseManager = FirebaseManager()
        
    @Published private var taskList: [MyTask] = []
    
    init() {
        firebaseManager.addListener(MyTask.self,
                             createCompletion: create,
                             updateCompletion: update,
                             deleteCompletion: delete)
    }
    
    func requestTaskListPublisher() -> AnyPublisher<[MyTask], Never> {
        return $taskList.eraseToAnyPublisher()
    }
    
    private func fetch() {
        guard let realmList = realmManager.readAll(type: RealmTask.self) else { return }
        
        taskList = realmList.map { MyTask($0) }
    }
    
    func create(_ task: MyTask) {
        guard !taskList.contains(task) else { return }
                
        taskList.append(task)
        
        let realmTask = RealmTask(task)
        
        realmManager.create(realmTask)
        firebaseManager.save(task)
    }
    
    func update(_ task: MyTask) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        
        taskList[safe: index] = task

        realmManager.update(task, type: RealmTask.self)
        firebaseManager.save(task)
    }
    
    func delete(_ task: MyTask) {
        taskList.removeAll { $0.id == task.id }
        
        realmManager.delete(type: RealmTask.self, id: task.id)
        firebaseManager.delete(type: MyTask.self, id: task.id)
    }
}
