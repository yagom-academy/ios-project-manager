import Foundation

enum TaskManagerError: Error {
    case taskNotFound
    case unchangedProcessStatus
    case updateNotFound
    case invalidTaskManagerAction
    case invalidProcessStatus
    case invalidViewModel
    
    var description: String {
        switch self {
        case .taskNotFound:
            return "존재하지 않는 Task입니다."
        case .unchangedProcessStatus:
            return "변경하려는 ProcessStatus가 기존과 동일합니다."
        case .updateNotFound:
            return "업데이트하려는 Task가 기존과 동일합니다."
        case .invalidTaskManagerAction:
            return "유효하지 않은 TaskManagerAction입니다."
        case .invalidProcessStatus:
            return "Task의 ProcessStatus가 유효하지 않습니다."
        case .invalidViewModel:
            return "ViewModel이 유효하지 않습니다."
        }
    }
}
