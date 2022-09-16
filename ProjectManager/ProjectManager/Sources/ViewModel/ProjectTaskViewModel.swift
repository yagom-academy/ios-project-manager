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
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title8",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date() + 100
        ),
        ProjectTask(
            id: UUID(),
            title: "done test title9",
            description: "done description@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
            date: Date()
        )
    ])

    lazy var todoCount = todoTasks
        .map { $0.map{_ in 1 }.reduce(0,+) }
    lazy var doingCount = doingTasks
        .map { $0.map{_ in 1 }.reduce(0,+) }
    lazy var doneCount = doneTasks
        .map { $0.map{_ in 1 }.reduce(0,+) }
}

extension ProjectTaskViewModel {
    func deleteTask(at state: ProjectTaskState, what index: Int) {
        var targetInstance: ProjectTask
        do {
            switch state {
            case .TODO:
                targetInstance = try todoTasks.value()[index]
                todoTasks.onNext(try todoTasks.value().filter{ $0.id != targetInstance.id })
            case .DOING:
                let targetInstance = try doingTasks.value()[index]
                doingTasks.onNext(try doingTasks.value().filter{ $0.id != targetInstance.id })
            case .DONE:
                targetInstance = try doneTasks.value()[index]
                doneTasks.onNext(try doneTasks.value().filter{ $0.id != targetInstance.id })
            }
        } catch {
            debugPrint("delete error")
        }
    }
    
    func updateTask(at state: ProjectTaskState, what target: ProjectTask) {
        do {
            switch state {
            case .TODO:
                todoTasks.onNext(try todoTasks.value().map({ task in
                    if task.id == target.id {
                        return target
                    }
                    return task
                }))
            case .DOING:
                doingTasks.onNext(try doingTasks.value().map({ task in
                    if task.id == target.id {
                        return target
                    }
                    return task
                }))
            case .DONE:
                doneTasks.onNext(try doneTasks.value().map({ task in
                    if task.id == target.id {
                        return target
                    }
                    return task
                }))
            }
        } catch {
            debugPrint("update error")
        }
    }
    
    func createTask(to task: ProjectTask, at state: ProjectTaskState) {
        do {
            var newTaskAppendedTasks: [ProjectTask]
            switch state {
            case .TODO:
                newTaskAppendedTasks = try todoTasks.value()
                newTaskAppendedTasks.append(task)
                todoTasks.onNext(newTaskAppendedTasks)
            case .DOING:
                newTaskAppendedTasks = try doingTasks.value()
                newTaskAppendedTasks.append(task)
                doingTasks.onNext(newTaskAppendedTasks)
            case .DONE:
                newTaskAppendedTasks = try doneTasks.value()
                newTaskAppendedTasks.append(task)
                doneTasks.onNext(newTaskAppendedTasks)
            }
            
        } catch {
            debugPrint("create error")
        }
    }
    
    func moveTask(to: ProjectTaskState, from: ProjectTaskState, id: UUID) {
        print(from)
        print(to)
        print(id)
        var targetTask: ProjectTask?
        do {
            switch from {
            case .TODO:
                targetTask = try todoTasks.value().filter{ $0.id == id }.first
                todoTasks.onNext(try todoTasks.value().filter{ $0.id != id })
            case .DOING:
                targetTask = try doingTasks.value().filter{ $0.id == id }.first
                doingTasks.onNext(try doingTasks.value().filter{ $0.id != id })
            case .DONE:
                targetTask = try doneTasks.value().filter{ $0.id == id }.first
                doneTasks.onNext(try doneTasks.value().filter{ $0.id != id })
            }
            guard let targetTask = targetTask else {
                return
            }
            createTask(to: targetTask , at: to)
        } catch {
            debugPrint("move - delete error")
        }
        
    }
}
