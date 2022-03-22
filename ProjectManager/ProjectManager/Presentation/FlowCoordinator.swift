import UIKit

protocol FlowCoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    
    func start()
    func showTaskDetailToAddTask()
    func showTaskDetailToEditTask(_ task: Task)
}

final class FlowCoordinator: FlowCoordinatorProtocol {
    weak var navigationController: UINavigationController?

    var taskListViewModel: TaskListViewModelProtocol!
    let taskDetailViewModel: TaskDetailViewModelProtocol = TaskDetailViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = TaskListViewModelActions(showTaskDetailToAddTask: showTaskDetailToAddTask,
                                               showTaskDetailToEditTask: showTaskDetailToEditTask)
        taskListViewModel = TaskListViewModel(actions: actions)
        
        guard let taskListViewController = ViewControllerFactory.createViewController(of: .taskList(viewModel: taskListViewModel)) as? TaskListViewController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        taskListViewController.flowCoordinator = self  // TODO: 각 ViewController의 flowCoordinator 삭제
        navigationController?.pushViewController(taskListViewController, animated: false)
    }
    
    func showTaskDetailToAddTask() {
        guard let taskDetailController = ViewControllerFactory.createViewController(of: .newTaskDetail(taskListViewModel: taskListViewModel, taskDetailViewModel: taskDetailViewModel)) as? TaskDetailController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        taskDetailController.flowCoordinator = self
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true, completion: nil)
    }
    
    func showTaskDetailToEditTask(_ task: Task) {
        guard let taskDetailController = ViewControllerFactory.createViewController(of: .editTaskDetail(taskListViewModel: taskListViewModel, taskDetailViewModel: taskDetailViewModel, taskToEdit: task)) as? TaskDetailController else {
            print(ViewControllerError.invalidViewController.description)
            return
        }
        taskDetailController.flowCoordinator = self
        navigationController?.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
}
