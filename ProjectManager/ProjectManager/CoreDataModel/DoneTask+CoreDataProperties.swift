//
//  DoneTask+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/21.
//
//

import Foundation
import CoreData

extension DoneTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoneTask> {
        return NSFetchRequest<DoneTask>(entityName: "DoneTask")
    }

    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var date: Double
    @NSManaged public var status: String

}

extension DoneTask: Identifiable, Task {

}
