//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import Foundation

import RxSwift
import RxRelay

final class TaskListViewModel {
    private let fetchTasksUseCase: FetchTasksUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let createButtonTapEvent: Observable<Void>
        let indexPathToDelete: Observable<IndexPath>
        let indexPathToLongPress: Observable<IndexPath>
        let selectedTaskEvent: Observable<IndexPath>
    }
    
    struct Output {
        let kanbanBoardModels = BehaviorRelay<[KanbanBoardModel]>(value: [])
    }
    
    private let tasks = BehaviorSubject<[Task.State: [Task]]>(value: [:])
    
    init(fetchTasksUseCase: FetchTasksUseCase, deleteTaskUseCase: DeleteTaskUseCase) {
        self.fetchTasksUseCase = fetchTasksUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        bind(with: input)
        
        tasks.subscribe(onNext: { tasks in
            var kanbanBoardModels: [KanbanBoardModel] = []
            Task.State.allCases.forEach {
                kanbanBoardModels.append(KanbanBoardModel(state: $0, tasks: tasks[$0, default: []]))
            }
            output.kanbanBoardModels.accept(kanbanBoardModels)
        })
        .disposed(by: disposeBag)
        
        return output
    }
}

private extension TaskListViewModel {
    func bind(with input: Input) {
        input.viewWillAppearEvent
            .subscribe(onNext: { [weak self] _ in
                self?.fetchTasksUseCase.fetchAllTasks()
            })
            .disposed(by: disposeBag)
        
        input.indexPathToDelete
            .subscribe(onNext: { [weak self] indexPath in
                self?.delete(at: indexPath)
            })
            .disposed(by: disposeBag)
        
        input.createButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                //coordinator to do
            })
            .disposed(by: disposeBag)
        
        input.indexPathToLongPress
            .subscribe(onNext: { [weak self] indexPath in
                //coordinator to do
            })
            .disposed(by: disposeBag)
        
        input.selectedTaskEvent
            .subscribe(onNext: { [weak self] indexPath in
                //coordinator to do
            })
            .disposed(by: disposeBag)
        
        fetchTasksUseCase.tasks
            .subscribe(onNext: { [weak self] tasks in
                let classifiedTasks = tasks.reduce(into: [Task.State: [Task]]()) {
                    $0[$1.state, default: []].append($1)
                }
                self?.tasks.onNext(classifiedTasks)
            })
            .disposed(by: disposeBag)
    }
    
    func delete(at indexPath: IndexPath) {
        guard let state = Task.State.init(rawValue: indexPath.section),
              let task = try? tasks.value()[state]?[indexPath.item] else {
            return
        }
        deleteTaskUseCase.delete(task)
    }
}
