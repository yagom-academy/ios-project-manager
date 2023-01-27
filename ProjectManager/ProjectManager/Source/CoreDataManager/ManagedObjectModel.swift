//  ProjectManager - ManagedObjectModel.swift
//  created by zhilly on 2023/01/27

import CoreData.NSManagedObject

protocol ManagedObjectModel: Hashable {
    associatedtype Object: NSManagedObject
    var objectID: String? { get set }
    
    init?(from: Object)
}

extension ManagedObjectModel {
    public static func == (lhs: any ManagedObjectModel, rhs: any ManagedObjectModel) -> Bool {
        return lhs.objectID == rhs.objectID
    }
}
