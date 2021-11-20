//
//  HistoryEntity+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/13.
//
//

import Foundation
import CoreData


extension HistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryEntity> {
        return NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var updateType: String

}

extension HistoryEntity : Identifiable {

}
