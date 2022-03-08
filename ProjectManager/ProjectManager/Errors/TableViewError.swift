import Foundation

enum TableViewError: Error {
    case invalidTableView
    
    var description: String {
        switch self {
        case .invalidTableView:
            return "유효한 TableView가 존재하지 않습니다."
        }
    }
}
