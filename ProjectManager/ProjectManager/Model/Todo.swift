//
//  Todo.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/05.
//

import Foundation

private enum Const {
    static let empty = ""
}

struct Todo {
    var todoListItemStatus: TodoListItemStatus
    let identifier: UUID
    let title: String
    let description: String
    let date: Date
    
    init(
        todoListItemStatus: TodoListItemStatus = .todo,
        identifier: UUID = UUID(),
        title: String = Const.empty,
        description: String = Const.empty,
        date: Date = Date()
    ) {
        self.todoListItemStatus = todoListItemStatus
        self.identifier = identifier
        self.title = title
        self.description = description
        self.date = date
    }
    
    func convertRealmTodo() -> TodoDTO {
        return TodoDTO(
            todoListItemStatus: self.todoListItemStatus,
            identifier: self.identifier,
            title: self.title,
            body: self.description,
            date: self.date
        )
    }
    
    func convertHistory(action: Action, status: HistoryStatus) -> History {
        return History(
            action: action,
            title: self.title,
            status: status,
            date: self.date
        )
    }
}

extension Todo: Serializable {
    var dictionary: [String: Any] {
        return [
            "todoListItemStatus": self.todoListItemStatus.displayName,
            "identifier": self.identifier.uuidString,
            "title": self.title,
            "description": self.description,
            "date": self.date.convertToString()
        ]
    }
    
    init?(dictionary: [String : Any]) {        
        guard let status = dictionary["todoListItemStatus"] as? String,
              let uuid = dictionary["identifier"] as? String,
              let title = dictionary["title"] as? String,
              let description = dictionary["description"] as? String,
              let date = dictionary["date"] as? String
        else {
            return nil
        }
        
        guard let todoListItemStatus = TodoListItemStatus(rawValue: status),
              let identifier = UUID(uuidString: uuid),
              let date = date.convertToDate()
        else {
            return nil
        }
        
        self.init(
            todoListItemStatus: todoListItemStatus,
            identifier: identifier,
            title: title,
            description: description,
            date: date
        )
    }
}
