//
//  Project+CoreDataProperties.swift
//  ProjectManager
//
//  Created by dhoney96 on 2022/09/07.
//
//

import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var deadLine: Date?
    @NSManaged public var section: String?
    @NSManaged public var id: UUID?

}

extension Project : Identifiable {

}
