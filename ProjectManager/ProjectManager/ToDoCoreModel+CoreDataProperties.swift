//  ProjectManager - ToDoCoreModel+CoreDataProperties.swift
//  created by zhilly on 2023/01/27

import Foundation
import CoreData

extension ToDoCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoCoreModel> {
        return NSFetchRequest<ToDoCoreModel>(entityName: "ToDoCoreModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var state: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var deadline: Date?
    
    var toDoState: ToDoState {
        get {
            return ToDoState(rawValue: state) ?? .toDo
        }
        set {
            state = newValue.rawValue
        }
    }
}
