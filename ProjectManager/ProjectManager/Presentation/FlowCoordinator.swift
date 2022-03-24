import UIKit

protocol FlowCoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    
    func start()
    func showTaskDetailToAddTask()
    func showTaskDetailToEditTask(_ task: Task)
    func presentPopover(with alert: UIAlertController)
}

final class FlowCoordinator: FlowCoordinatorProtocol {
    // TODO: rootViewController: UIViewController로 변경
    weak var navigationController: UINavigationController?

    private var taskRepository: TaskRepositoryProtocol!
    private var taskListViewModel: TaskListViewModelProtocol!
    private var taskDetailViewModel: TaskDetailViewModelProtocol!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = TaskListViewModelActions(showTaskDetailToAddTask: showTaskDetailToAddTask,
                                               showTaskDetailToEditTask: showTaskDetailToEditTask,
                                               presentPopover: presentPopover)
        
        // 2개 ViewModel에 동일한 Repository를 할당
        taskRepository = TaskRepository()
        taskListViewModel = TaskListViewModel(taskRepository: taskRepository, actions: actions)
        taskDetailViewModel = TaskDetailViewModel(taskRepository: taskRepository)
        
        guard let taskListViewController = ViewControllerFactory.createViewController(of: .taskList(viewModel: taskListViewModel)) as? TaskListViewController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.pushViewController(taskListViewController, animated: false)
    }
    
    // MARK: - TaskListView -> TaskDetailView 화면 이동
    func showTaskDetailToAddTask() {
        guard let taskDetailController = ViewControllerFactory.createViewController(of: .addTaskDetail(taskDetailViewModel: taskDetailViewModel)) as? TaskDetailController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true, completion: nil)
    }
    
    func showTaskDetailToEditTask(_ task: Task) {
        guard let taskDetailController = ViewControllerFactory.createViewController(of: .editTaskDetail(taskDetailViewModel: taskDetailViewModel, taskToEdit: task)) as? TaskDetailController else {
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
