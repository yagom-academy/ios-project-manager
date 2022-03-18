import UIKit

protocol TaskDetailViewModelProtocol {
    func leftBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem
    func rightBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem
}

final class TaskDetailViewModel: TaskDetailViewModelProtocol {
    func leftBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem {
        switch taskManagerAction {
        case .add:
            return .cancel
        case .edit:
            return .cancel
        }
    }
    
    func rightBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem {
        switch taskManagerAction {
        case .add:
            return .done
        case .edit:
            return .edit
        }
    }
}
