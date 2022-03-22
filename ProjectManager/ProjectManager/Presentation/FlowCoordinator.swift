import UIKit

protocol FlowCoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    
    func start()
    func showTaskDetailToAddTask()
    func showTaskDetailToEditTask(_ task: Task)
    func presentPopover(with alert: UIAlertController)
}

final class FlowCoordinator: FlowCoordinatorProtocol {
    weak var navigationController: UINavigationController? // TODO: rootViewController: UIViewController로 변경

    var taskListViewModel: TaskListViewModelProtocol!
    let taskDetailViewModel: TaskDetailViewModelProtocol = TaskDetailViewModel()
    
    var taskRepository: TaskRepositoryProtocol!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = TaskListViewModelActions(showTaskDetailToAddTask: showTaskDetailToAddTask,
                                               showTaskDetailToEditTask: showTaskDetailToEditTask,
                                               presentPopover: presentPopover)
        taskRepository = TaskRepository()
        taskListViewModel = TaskListViewModel(taskRepository: taskRepository, actions: actions)
        
        guard let taskListViewController = ViewControllerFactory.createViewController(of: .taskList(viewModel: taskListViewModel)) as? TaskListViewController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.pushViewController(taskListViewController, animated: false)
    }
    
    // MARK: - TaskListView -> TaskDetailView 화면 이동
    func showTaskDetailToAddTask() {
        guard let taskDetailController = ViewControllerFactory.createViewController(of: .newTaskDetail(taskListViewModel: taskListViewModel, taskDetailViewModel: taskDetailViewModel)) as? TaskDetailController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true, completion: nil)
    }
    
    func showTaskDetailToEditTask(_ task: Task) {
        guard let taskDetailController = ViewControllerFactory.createViewController(of: .editTaskDetail(taskListViewModel: taskListViewModel, taskDetailViewModel: taskDetailViewModel, taskToEdit: task)) as? TaskDetailController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
    
    // MARK: - TaskListView -> Popover 띄우기
    func presentPopover(with alert: UIAlertController) {
        navigationController?.present(alert, animated: true)
    }
}
