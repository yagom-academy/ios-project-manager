import Foundation
import CoreData


private enum Tag {
    static let todo: Int16 = 0
    static let doing: Int16 = 1
    static let done: Int16 = 2
}

extension Work {
    
    enum Category {
        case todo
        case doing
        case done
        
        var tag: Int16 {
            switch self {
            case .todo:
                return Tag.todo
            case .doing:
                return Tag.doing
            case .done:
                return Tag.done
            }
        }
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Work> {
        return NSFetchRequest<Work>(entityName: "Work")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var categoryTag: Int16
    
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
