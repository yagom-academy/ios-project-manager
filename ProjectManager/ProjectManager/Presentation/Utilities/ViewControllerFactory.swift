import UIKit

struct StoryboardInformation {
    let bundle: Bundle?
    let storyboardName: String
    let storyboardId: String
}

enum TypeOfViewController {
    case taskList(viewModel: TaskListViewModelProtocol)
    case newTaskDetail(taskDetailViewModel: TaskDetailViewModelProtocol)
    case editTaskDetail(taskDetailViewModel: TaskDetailViewModelProtocol, taskToEdit: Task)
}

extension TypeOfViewController {
    func fetchStoryboardInformation() -> StoryboardInformation {
        switch self {
        case .taskList:
            return StoryboardInformation(bundle: nil, storyboardName: "TaskListViewController", storyboardId: "TaskListViewController")
        case .newTaskDetail, .editTaskDetail:
            return StoryboardInformation(bundle: nil, storyboardName: "TaskDetailController", storyboardId: "TaskDetailController")
        }
    }
}

enum ViewControllerFactory {
    static func createViewController(of typeOfViewController: TypeOfViewController) -> UIViewController {
        let storyboardInformation = typeOfViewController.fetchStoryboardInformation()
        let storyboard = UIStoryboard(name: storyboardInformation.storyboardName, bundle: storyboardInformation.bundle)
        
        switch typeOfViewController {
        case .taskList(let viewModel):
            let taskListViewController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskListViewController(coder: coder, taskListViewModel: viewModel)
            }
            return taskListViewController
        case .newTaskDetail(let taskDetailViewModel):
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
