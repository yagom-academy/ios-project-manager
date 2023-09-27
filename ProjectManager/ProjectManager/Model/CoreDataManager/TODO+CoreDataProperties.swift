//
//  TODO+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/27.
//
//

import CoreData

extension TODO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TODO> {
        return NSFetchRequest<TODO>(entityName: "TODO")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var date: Date?
}

extension TODO : Identifiable {
    @NSManaged public var id: UUID?
}
