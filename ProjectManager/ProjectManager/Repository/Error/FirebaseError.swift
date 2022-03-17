import Foundation

enum FirebaseError: LocalizedError {
    case fetchFailed
    case createFailed
    case updateFailed
    case deleteFailed
    
    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "RemoteDB Fetch Failed".localized()
        case .createFailed:
            return "RemoteDB Create Failed".localized()
        case .updateFailed:
            return "RemoteDB Update Failed".localized()
        case .deleteFailed:
            return "RemoteDB Delete Failed".localized()
        }
    }
}
