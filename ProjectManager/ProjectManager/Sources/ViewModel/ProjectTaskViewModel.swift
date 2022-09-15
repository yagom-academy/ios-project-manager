//
//  ProjectTaskViewModel.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/14.
//

import RxSwift
import Foundation

final class ProjectTaskViewModel {
    
    private let disposeBag = DisposeBag()
    var selectedTask: ProjectTask?
    
    let todoTasks = BehaviorSubject<[ProjectTask]>(value: [
        ProjectTask(
            id: UUID(),
            title: "todo test title",
            description: "todo description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        )
    ])
    let doingTasks = BehaviorSubject<[ProjectTask]>(value: [
        ProjectTask(
            id: UUID(),
            title: "doing test title1",
            description: "doing description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        )])
    let doneTasks = BehaviorSubject<[ProjectTask]>(value: [
        ProjectTask(
            id: UUID(),
            title: "done test title2",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title3",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title4",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title5",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title6",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title7",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        )
    ])

    lazy var todoCount = todoTasks
        .map { $0.map{_ in 1}.reduce(0,+) }
    lazy var doingCount = doingTasks
        .map { $0.map{_ in 1}.reduce(0,+) }
    lazy var doneCount = doneTasks
        .map { $0.map{_ in 1}.reduce(0,+) }
}

extension ProjectTaskViewModel {
    func deleteTask(at state: ProjetTaskState, what target: Int) {
        var targetInstance: ProjectTask
        do {
            switch state {
            case .TODO:
                targetInstance = try todoTasks.value()[target]
                todoTasks.onNext(try todoTasks.value().filter{ $0.id != targetInstance.id })
            case .DOING:
                let targetInstance = try doingTasks.value()[target]
                doingTasks.onNext(try doingTasks.value().filter{ $0.id != targetInstance.id })
            case .DONE:
                targetInstance = try doneTasks.value()[target]
                doneTasks.onNext(try doneTasks.value().filter{ $0.id != targetInstance.id })
            default:
                break
            }
        } catch {
            debugPrint("delete error")
        }
    }
}
