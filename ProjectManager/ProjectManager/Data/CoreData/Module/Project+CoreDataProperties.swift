//
//  Project+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/28.
//
//

import Foundation
import CoreData

extension Project {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var body: String?
    @NSManaged public var workState: String?
    @NSManaged public var date: Date?

}

extension Project: Identifiable {}
