import UIKit

protocol TaskDetailViewModelInputProtocol {
    func leftBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem
    func rightBarButton(of taskManagerAction: TaskManagerAction) -> UIBarButtonItem.SystemItem
}

protocol TaskDetailViewModelOutputProtocol { }

protocol TaskDetailViewModelProtocol: TaskDetailViewModelInputProtocol, TaskDetailViewModelOutputProtocol { }

final class TaskDetailViewModel: TaskDetailViewModelProtocol {
    // TODO: UseCase 추가
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
