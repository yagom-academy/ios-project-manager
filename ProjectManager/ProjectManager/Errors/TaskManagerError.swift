import Foundation

enum TaskManagerError: Error {
    case taskNotFound
    case unchangedProcessStatus
    
    var description: String {
        switch self {
        case .taskNotFound:
            return "존재하지 않는 Task입니다."
        case .unchangedProcessStatus:
            return "변경하려는 ProcessStatus가 기존과 동일합니다."
        }
    }
}
