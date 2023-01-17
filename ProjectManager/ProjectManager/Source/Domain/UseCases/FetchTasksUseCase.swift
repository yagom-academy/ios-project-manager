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
            .subscribe(onNext: { [weak self] taskEntities in
                let translater = Translater()
                self?.tasks.onNext(
                    taskEntities.compactMap(translater.toDomain)
                )
            })
            .disposed(by: disposeBag)
    }
}
