//
//  MockTaskRepository.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

final class MockTaskRepository: TaskRepository {
    private var taskEntities: [TaskEntity]
    
    init(taskEntities: [TaskEntity]) {
        self.taskEntities = taskEntities
    }
    
    func create(_ task: TaskEntity) -> Observable<Bool> {
        taskEntities.append(task)
        
        return Observable.just(true)
    }
    
    func fetchAllTaskList() -> Observable<[TaskEntity]> {
        return Observable.just(taskEntities)
    }
    
    func update(_ task: TaskEntity) -> Observable<Bool> {
        guard let index = taskEntities.firstIndex(where: { $0.id == task.id }) else {
            return Observable.just(false)
        }
        
        taskEntities[index] = task
        
        return Observable.just(true)
    }
    
    func delete(_ task: TaskEntity) -> Observable<Bool> {
        guard let index = taskEntities.firstIndex(where: { $0.id == task.id }) else {
            return Observable.just(false)
        }
        
        taskEntities.remove(at: index)
        
        return Observable.just(true)
    }
}
