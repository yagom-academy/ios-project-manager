import Foundation

enum TableViewError: Error {
    case invalidTableView
    case initializerNotImplemented
    
    var description: String {
        switch self {
        case .invalidTableView:
            return "유효한 TableView가 존재하지 않습니다."
        case .initializerNotImplemented:
            return "init(code:)가 비정상 작동합니다."
        }
    }
}
