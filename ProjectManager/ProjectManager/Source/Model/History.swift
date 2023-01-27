//  ProjectManager - History.swift
//  created by zhilly on 2023/01/27

import Foundation

struct History: ManagedObjectModel {
    
    var objectID: String?
    let title: String
    let createdAt: Date
    
    init(objectID: String? = nil, title: String, createdAt: Date) {
        self.objectID = objectID
        self.title = title
        self.createdAt = createdAt
    }
    
    init?(from historyCoreModel: HistoryCoreModel) {
        guard let title = historyCoreModel.title,
              let createdAt = historyCoreModel.createdAt else {
            return nil
        }
        
        self.title = title
        self.createdAt = createdAt
        self.objectID = historyCoreModel.objectID.uriRepresentation().absoluteString
    }
}
