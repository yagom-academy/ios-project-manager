//
//  Project.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/05.
//

import RealmSwift

protocol FirebaseDatable: Codable {
    var detailPath: [String] { get }
    static var path: [String] { get }
}

class Task: Object, FirebaseDatable {
    static var path: [String] = ["task"]
    
    var detailPath: [String] {
        var newPath = Task.path
        newPath.append(id)
        return newPath
    }
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String?
    @Persisted private(set) var dateInfo: String
    @Persisted var body: String?
    @Persisted var type: String?
    
    var taskType: TaskType? {
        get {
            TaskType(rawValue: type ?? "")
        }
    }
    
    var date: Date {
        get {
            dateInfo.toDate ?? Date.today
        }
        set {
            dateInfo = newValue.isoDateString
        }
    }
    
    convenience init(id: String = UUID().uuidString, title: String?, date: Date, body: String?,
                     type: TaskType = .todo) {
        self.init()
        self.id = id
        self.title = title
        self.date = date
        self.body = body
        self.type = type.rawValue
    }
}
