//
//  FetchTasksUseCase.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxRelay
import RxSwift

final class FetchTasksUseCase {
    var tasks = BehaviorSubject<[Task]>(value: [])
    private let taskRepository: TaskRepository
    private let disposeBag = DisposeBag()
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func fetchTasks() {
        taskRepository.fetchAllTaskList()
            .map { $0.compactMap(Translater().toDomain) }
            .subscribe(onNext: { [weak self] tasks in
                self?.tasks.onNext(tasks)
            })
            .disposed(by: disposeBag)
    }
}

extension FetchTasksUseCase: DidEndEditingTaskDelegate {
    func didEndCreating(task: Task) {
        guard var tasksList = try? tasks.value() else {
            return
        }
        
        tasksList.append(task)
        tasks.onNext(tasksList)
    }
    
    func didEndUpdating(task: Task) {
        guard var tasksList = try? tasks.value(),
              let index = tasksList.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        
        tasksList[index] = task
        tasks.onNext(tasksList)
    }
    
    func didEndDeleting(task: Task) {
        guard var tasksList = try? tasks.value(),
              let index = tasksList.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        
        tasksList.remove(at: index)
        tasks.onNext(tasksList)
    }
}
