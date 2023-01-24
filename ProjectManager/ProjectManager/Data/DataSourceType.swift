//
//  DataSourceType.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import RxSwift

protocol DataSourceType {
    func fetch() -> Observable<[Task]>
    func create(task: Task) -> Observable<Task>
    func update(task: Task) -> Observable<Task>
    func delete(task: Task) -> Observable<Task>
}
