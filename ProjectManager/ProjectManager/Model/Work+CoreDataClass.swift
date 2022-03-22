import Foundation
import CoreData


@objc(Work)
public class Work: NSManagedObject {
    
    convenience init(id: UUID = UUID(), title: String?, body: String?, dueDate: Date?, categoryTag: Int16) {
        self.init()
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.categoryTag = categoryTag
    }
    
}
