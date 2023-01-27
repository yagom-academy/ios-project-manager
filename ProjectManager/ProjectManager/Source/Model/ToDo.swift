//  ProjectManager - ToDo.swift
//  created by zhilly on 2023/01/13

import Foundation

struct ToDo: ManagedObjectModel {
    
    var objectID: String?
    var title: String
    var body: String
    var deadline: Date
    var state: ToDoState
    
    init(objectID: String? = nil, title: String, body: String, deadline: Date, state: ToDoState) {
        self.objectID = objectID
        self.title = title
        self.body = body
        self.deadline = deadline
        self.state = state
    }
    
    init?(from toDoCoreModel: ToDoCoreModel) {
        guard let title = toDoCoreModel.title,
              let body = toDoCoreModel.body,
              let deadline = toDoCoreModel.deadline else {
            return nil
        }
        
        self.title = title
        self.body = body
        self.deadline = deadline
        self.state = toDoCoreModel.toDoState
        self.objectID = toDoCoreModel.objectID.uriRepresentation().absoluteString
    }
    
    var isOverDeadline: Bool {
        return deadline < Date()
    }
}
