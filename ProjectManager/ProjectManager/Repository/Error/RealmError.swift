import Foundation

enum RealmError: LocalizedError {
    case fetchFailed
    case createFailed
    case updateFailed
    case deleteFailed
    
    var errorDescription: String? {
        switch self {
        case .fetchFailed:
            return "LocalDB Fetch Failed".localized()
        case .createFailed:
            return "LocalDB Create Failed".localized()
        case .updateFailed:
            return "LocalDB Update Failed".localized()
        case .deleteFailed:
            return "LocalDB Delete Failed".localized()
        }
    }
}
