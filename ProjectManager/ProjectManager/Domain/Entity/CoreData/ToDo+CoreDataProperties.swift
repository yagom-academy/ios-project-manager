//
//  ToDo+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String
    @NSManaged public var dueDate: Date
    @NSManaged public var body: String
    @NSManaged public var modifiedAt: Date
    @NSManaged public var status: String

}

extension ToDo : Identifiable {
    @NSManaged public var id: UUID
}
