//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

protocol TaskRepository {
    func create(_ task: TaskEntity) -> Observable<Bool>
    func fetchAllTaskList() -> Observable<[TaskEntity]>
    func update(_ task: TaskEntity) -> Observable<Bool>
    func delete(_ task: TaskEntity) -> Observable<Bool>
}
