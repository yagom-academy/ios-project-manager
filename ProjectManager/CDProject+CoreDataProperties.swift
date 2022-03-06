import Foundation
import CoreData


extension CDProject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProject> {
        return NSFetchRequest<CDProject>(entityName: "CDProject")
    }

    @NSManaged public var deadline: Date?
    @NSManaged public var detail: String?
    @NSManaged public var identifier: UUID?
    @NSManaged public var name: String?

}

extension CDProject : Identifiable {

}
