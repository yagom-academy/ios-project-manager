import Foundation

enum FirebaseError: LocalizedError {
    case fetchFailed
    case createFailed
    case updateFailed
    case deleteFailed
    
    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "Fetch Failed"
        case .createFailed:
            return "Create Failed"
        case .updateFailed:
            return "Update Failed"
        case .deleteFailed:
            return "Delete Failed"
        }
    }
}
