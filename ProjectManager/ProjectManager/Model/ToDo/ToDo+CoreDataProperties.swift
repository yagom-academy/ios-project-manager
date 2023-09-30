//
//  ToDo+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 조호준 on 2023/09/30.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var category: String?

}

extension ToDo : Identifiable {

}
