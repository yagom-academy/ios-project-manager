import Foundation
import CoreData


// MARK: - Namespace
private enum Tag {
    
    static let todo: Int16 = 0
    static let doing: Int16 = 1
    static let done: Int16 = 2
    
}

private enum Name {
    
    static let entity = "Work"
    
}

private enum Content {
    
    static let emptyString = ""
    
}

extension Work {
    
    // MARK: Nested Type
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
    
    // MARK: - NSManaged Properties
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var categoryTag: Int16
    
    // MARK: - Properties
    var convertedDate: String {
        guard let dueDate = dueDate else { return Content.emptyString }
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
    
    // MARK: - Method
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Work> {
        return NSFetchRequest<Work>(entityName: Name.entity)
    }
    
}
