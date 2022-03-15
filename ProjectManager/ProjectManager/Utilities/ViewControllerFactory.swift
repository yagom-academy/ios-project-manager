import UIKit

struct StoryboardInformation {
    let bundle: Bundle?
    let storyboardName: String
    let storyboardId: String
}

enum TypeOfViewController {
    case taskList(viewModel: TaskListViewModelProtocol)
    case newTaskDetail(viewModel: TaskListViewModelProtocol)
    case editTaskDetail(viewModel: TaskListViewModelProtocol, taskToEdit: Task)
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

struct ViewControllerFactory {
    static func createViewController(of typeOfViewController: TypeOfViewController) -> UIViewController {
        let storyboardInformation = typeOfViewController.fetchStoryboardInformation()
        let storyboard = UIStoryboard(name: storyboardInformation.storyboardName, bundle: storyboardInformation.bundle)
        
        switch typeOfViewController {
        case .taskList(let viewModel):
            let taskListViewController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskListViewController(coder: coder, taskListViewModel: viewModel)
            }
            return taskListViewController
        case .newTaskDetail(let viewModel):
            let taskDetailController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskDetailController(coder: coder, taskListViewModel: viewModel, taskManagerAction: .add, taskToEdit: nil)
            }
            return taskDetailController
        case .editTaskDetail(let viewModel, let taskToEdit):
            let taskDetailController = storyboard.instantiateViewController(identifier: storyboardInformation.storyboardId) { coder in
                return TaskDetailController(coder: coder, taskListViewModel: viewModel, taskManagerAction: .edit, taskToEdit: taskToEdit)
            }
            return taskDetailController
        }
    }
}
