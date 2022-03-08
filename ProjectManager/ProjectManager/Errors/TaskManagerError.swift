import Foundation

enum TaskManagerError: Error {
    case taskNotFound
    
    var description: String {
        switch self {
        case .taskNotFound:
            return "존재하지 않는 Task입니다."
        }
    }
}
