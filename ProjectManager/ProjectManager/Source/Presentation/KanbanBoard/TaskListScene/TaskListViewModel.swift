//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import Foundation

import RxSwift
import RxRelay

struct TaskListViewModelActions {
    let showTaskCreateScene: (DidEndCreatingTaskDelegate?) -> Void
    let showTaskDetailScene: (Task, @escaping (_ isTappedEditButton: Bool) -> Void) -> Void
    let showTaskEditScene: (Task, DidEndUpdatingDelegate?) -> Void
    let showStateUpdatePopover: (Task, CGRect, DidEndUpdatingDelegate?) -> Void
}

final class TaskListViewModel {
    typealias PopoverMaterials = (indexPath: IndexPath, rect: CGRect)
    private let fetchTasksUseCase: FetchTasksUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase
    private let disposeBag = DisposeBag()
    private let action: TaskListViewModelActions?
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let createButtonTapEvent: Observable<Void>
        let indexPathToDelete: Observable<IndexPath>
        let indexPathToLongPress: Observable<PopoverMaterials>
        let selectedTaskEvent: Observable<IndexPath>
    }
    
    struct Output {
        let kanbanBoardModels = BehaviorRelay<[KanbanBoardModel]>(value: [])
    }
    
    private let tasks = BehaviorSubject<[Task.State: [Task]]>(value: [:])
    
    init(fetchTasksUseCase: FetchTasksUseCase,
         deleteTaskUseCase: DeleteTaskUseCase,
         action: TaskListViewModelActions? = nil) {
        self.fetchTasksUseCase = fetchTasksUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
        self.action = action
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
                self?.action?.showTaskCreateScene(self?.fetchTasksUseCase)
            })
            .disposed(by: disposeBag)
        
        input.indexPathToLongPress
            .subscribe(onNext: { [weak self] materials in
                self?.showStateUpdatePopover(at: materials.indexPath,
                                             sourceRect: materials.rect)
            })
            .disposed(by: disposeBag)
        
        input.selectedTaskEvent
            .subscribe(onNext: { [weak self] indexPath in
                self?.showTaskDetail(at: indexPath)
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
    
    func showTaskDetail(at indexPath: IndexPath) {
        guard let state = Task.State.init(rawValue: indexPath.section),
              let task = try? tasks.value()[state]?[indexPath.item] else {
            return
        }
        action?.showTaskDetailScene(task) { [weak self] isTappedEditButton in
            if isTappedEditButton {
                self?.action?.showTaskEditScene(task, self?.fetchTasksUseCase)
            }
        }
    }
    
    func showStateUpdatePopover(at indexPath: IndexPath, sourceRect: CGRect) {
        guard let state = Task.State.init(rawValue: indexPath.section),
              let task = try? tasks.value()[state]?[indexPath.item] else {
            return
        }
        action?.showStateUpdatePopover(task, sourceRect, fetchTasksUseCase)
    }
}
