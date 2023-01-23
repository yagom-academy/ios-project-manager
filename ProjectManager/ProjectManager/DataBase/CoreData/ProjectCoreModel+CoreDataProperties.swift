//
//  ProjectCoreModel+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/23.
//

import Foundation
import CoreData

extension ProjectCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectCoreModel> {
        return NSFetchRequest<ProjectCoreModel>(entityName: "ProjectCoreModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var date: Date
    @NSManaged public var uuid: UUID
    @NSManaged public var stateRawValue: Int

    var state: ProjectState {
        get {
            return ProjectState(rawValue: stateRawValue) ?? .todo
        }
        set {
            stateRawValue = newValue.rawValue
        }
    }
}
