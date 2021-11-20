//
//  MemoEntity+CoreDataProperties.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/10.
//
//

import Foundation
import CoreData


extension MemoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoEntity> {
        return NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
    }

    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var state: String

}

extension MemoEntity : Identifiable {

}
