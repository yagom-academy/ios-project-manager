import UIKit

enum TaskManagerAction {
    case add
    case edit
    
    var leftBarButton: UIBarButtonItem.SystemItem {
        switch self {
        case .add:
            return .cancel
        case .edit:
            return .cancel
        }
    }
    
    var rightBarButton: UIBarButtonItem.SystemItem {
        switch self {
        case .add:
            return .done
        case .edit:
            return .edit
        }
    }
}
