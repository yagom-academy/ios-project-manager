//
//  KanbanBoardCoordinator.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/21.
//

import UIKit

final class KanbanBoardCoordinator {
    private let navigationController: UINavigationController
    private var rootViewController: TaskListViewController?
    private let repository = MockTaskRepository.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let taskListViewController = createTaskListViewController()
        rootViewController = taskListViewController
        navigationController.pushViewController(taskListViewController, animated: true)
    }
    
    func showTaskCreateScene(with delegate: DidEndCreatingTaskDelegate?) {
        let createTaskUseCase = DefaultCreateTaskUseCase(delegate: delegate,
                                                         repository: repository)
        let taskCreateViewModel = TaskCreateViewModel(createTaskUseCase: createTaskUseCase)
        let taskCreateVC = TaskCreateViewController(viewModel: taskCreateViewModel)
        let taskCreateNavigationController = UINavigationController(rootViewController: taskCreateVC)
        
        navigationController.present(taskCreateNavigationController, animated: true)
    }
    
    func showTaskDetailScene(of task: Task,
                             didTappedEditButtonHandler: @escaping (_ isTappedEditButton: Bool) -> Void) {
        let taskDetailViewModel = TaskDetailViewModel(task: task,
                                                      didTappedEditButtonHandler: didTappedEditButtonHandler)
        let taskDetailVC = TaskDetailViewController(viewModel: taskDetailViewModel)
        let taskDetailNavigationController = UINavigationController(rootViewController: taskDetailVC)
        
        navigationController.present(taskDetailNavigationController, animated: true)
    }
    
    func showTaskEditScene(of task: Task, didEndUpdatingDelegate: DidEndUpdatingDelegate?) {
        let updateTaskUseCase = DefaultUpdateTaskUseCase(delegate: didEndUpdatingDelegate,
                                                         repository: repository)
        let taskEditViewModel = TaskEditViewModel(task: task,
                                                  updateTaskUseCase: updateTaskUseCase)
        let taskEditVC = TaskEditViewController(viewModel: taskEditViewModel)
        let taskEditNavigationController = UINavigationController(rootViewController: taskEditVC)
        
        navigationController.present(taskEditNavigationController, animated: true)
    }
    
    func showStateUpdatePopover(
        of task: Task,
        sourceRect: CGRect,
        didEndUpdatingDelegate: DidEndUpdatingDelegate?
    ) {
        let updateTaskUseCase = DefaultUpdateTaskUseCase(delegate: didEndUpdatingDelegate,
                                                         repository: repository)
        let stateUpdateViewModel = StateUpdateViewModel(updateTaskUseCase: updateTaskUseCase,
                                                        task: task)
        let stateUpdateVC = StateUpdateViewController(viewModel: stateUpdateViewModel,
                                                      style: task.state)
        
        stateUpdateVC.modalPresentationStyle = .popover
        stateUpdateVC.popoverPresentationController?.sourceView = rootViewController?.view
        stateUpdateVC.popoverPresentationController?.sourceRect = sourceRect
        stateUpdateVC.popoverPresentationController?.permittedArrowDirections = .up
        
        navigationController.present(stateUpdateVC, animated: true)
    }
    
    private func createTaskListViewController() -> TaskListViewController {
        let fetchTasksUseCase = DefaultFetchTasksUseCase(taskRepository: repository)
        let deleteTaskUseCase = DefaultDeleteTaskUseCase(delegate: fetchTasksUseCase,
                                                         repository: repository)
        let taskListViewModelActions = TaskListViewModelActions(
            showTaskCreateScene: showTaskCreateScene,
            showTaskDetailScene: showTaskDetailScene,
            showTaskEditScene: showTaskEditScene,
            showStateUpdatePopover: showStateUpdatePopover)
        let taskListViewModel = TaskListViewModel(fetchTasksUseCase: fetchTasksUseCase,
                                                  deleteTaskUseCase: deleteTaskUseCase,
                                                  action: taskListViewModelActions)
        return TaskListViewController(viewModel: taskListViewModel)
    }
}
