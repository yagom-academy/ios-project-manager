import UIKit

struct StoryboardInformation {
    let bundle: Bundle?
    let storyboardName: String
    let storyboardId: String
}

enum TypeOfViewController {
    case taskList(taskViewModel: TaskViewModelProtocol, taskListViewModel: TaskListViewModelProtocol)
    case addTaskDetail(taskDetailViewModel: TaskDetailViewModelProtocol)
    case editTaskDetail(taskDetailViewModel: TaskDetailViewModelProtocol, taskToEdit: Task)
}

extension TypeOfViewController {
    func fetchStoryboardInformation() -> StoryboardInformation {
        switch self {
        case .taskList:
            return StoryboardInformation(bundle: nil, storyboardName: "TaskListViewController", storyboardId: "TaskListViewController")
        case .addTaskDetail, .editTaskDetail:
            return StoryboardInformation(bundle: nil, storyboardName: "TaskDetailController", storyboardId: "TaskDetailController")
        }
    }
}

enum ViewControllerFactory {
    static func createViewController(of typeOfViewController: TypeOfViewController) -> UIViewController {
        let storyboardInformation = typeOfViewController.fetchStoryboardInformation()
        let storyboard = UIStoryboard(name: storyboardInformation.storyboardName, bundle: storyboardInformation.bundle)
        
        switch typeOfViewController {
        case .taskList(let taskViewModel, let taskListViewModel):
            let taskListViewController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskListViewController(coder: coder, taskViewModel: taskViewModel, taskListViewModel: taskListViewModel)
            }
            return taskListViewController
        case .addTaskDetail(let taskDetailViewModel):
            let taskDetailController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskDetailController(coder: coder, taskDetailViewModel: taskDetailViewModel, taskManagerAction: .add, taskToEdit: nil)
            }
            return taskDetailController
        case .editTaskDetail(let taskDetailViewModel, let taskToEdit):
            let taskDetailController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskDetailController(coder: coder, taskDetailViewModel: taskDetailViewModel, taskManagerAction: .edit, taskToEdit: taskToEdit)
            }
            return taskDetailController
        }
    }
}
