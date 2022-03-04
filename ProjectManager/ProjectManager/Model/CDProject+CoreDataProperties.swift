import Foundation
import CoreData

extension CDProject: Listable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProject> {
        return NSFetchRequest<CDProject>(entityName: "CDProject")
    }

    @NSManaged public var name: String
    @NSManaged public var detail: String
    @NSManaged public var deadline: Date
    @NSManaged public var identifier: UUID?

}

extension CDProject : Identifiable {

}
