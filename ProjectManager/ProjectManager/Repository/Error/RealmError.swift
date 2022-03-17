import Foundation

enum RealmError: LocalizedError {
    case fetchFailed
    case createFailed
    case updateFailed
    case deleteFailed
    
    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "LocalDB Fetch Failed"
        case .createFailed:
            return "LocalDB Create Failed"
        case .updateFailed:
            return "LocalDB Update Failed"
        case .deleteFailed:
            return "LocalDB Delete Failed"
        }
    }
}
