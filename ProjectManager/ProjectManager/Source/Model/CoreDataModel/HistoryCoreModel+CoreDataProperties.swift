//  ProjectManager - HistoryCoreModel+CoreDataProperties.swift
//  created by zhilly on 2023/01/27

import Foundation
import CoreData

extension HistoryCoreModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryCoreModel> {
        return NSFetchRequest<HistoryCoreModel>(entityName: "HistoryCoreModel")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?
}
