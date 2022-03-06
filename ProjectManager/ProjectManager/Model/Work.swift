import Foundation

struct Work {
    
    enum Sort {
        case todo
        case doing
        case done
    }
    
    var id: UUID = UUID()
    var title: String?
    var body: String?
    var dueDate: Date?
    var sort: Sort = .todo
    
    var convertedDate: String {
        guard let dueDate = dueDate else { return "" }
        let dateFormatter = DateFormatter.shared
        
        return dateFormatter.string(from: dueDate)
    }
    var isExpired: Bool {
        let dateFormatter = DateFormatter.common
        if convertedDate < dateFormatter.string(from: Date()) {
            return true
        }
        return false
    }
}
