//
//  TodoModel+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/15.
//
//

import Foundation
import CoreData

extension TodoModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var todoDate: Date?
    @NSManaged public var id: UUID?
}

extension TodoModel: Identifiable {

}
