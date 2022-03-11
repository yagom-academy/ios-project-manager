import Foundation


struct Work {
    
    enum Category {
        case todo
        case doing
        case done
    }
    
    let id: UUID = UUID()
    var title: String?
    var body: String?
    var dueDate: Date?
    var category: Category = .todo
    
    var convertedDate: String {
        guard let dueDate = dueDate else { return "" }
        let dateFormatter = DateFormatter.shared
        
        return dateFormatter.string(from: dueDate)
    }
    var isExpired: Bool {
        guard let dueDate = dueDate else { return false }
        let dateFormatter = DateFormatter.common
        if dateFormatter.string(from: dueDate) < dateFormatter.string(from: Date()) {
            return true
        }
        return false
    }
    
}
