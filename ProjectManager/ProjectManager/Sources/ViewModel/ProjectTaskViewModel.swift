//
//  ProjectTaskViewModel.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/14.
//

import RxSwift

class ProjectTaskViewModel {
    private let disposeBag = DisposeBag()
    
    let todoTasks = BehaviorSubject<[ProjectTask]>(value: [])
    let doingTasks = BehaviorSubject<[ProjectTask]>(value: [])
    let doneTasks = BehaviorSubject<[ProjectTask]>(value: [])

    lazy var todoCountImage = todoTasks
        .map { _ in 1 }
        .reduce( 0, accumulator: +)
    lazy var doingCountImage = doingTasks
        .map { _ in 1 }
        .reduce( 0, accumulator: +)
    lazy var doneCountImage = doneTasks
        .map { _ in 1}
        .reduce( 0, accumulator: +)
}
