//
//  Task.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import Foundation
import RealmSwift

final class Task: Object, Encodable {
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var date: Double
    @Persisted var taskType: TaskType
    @Persisted(primaryKey: true) var id: String
    
    convenience init(
        title: String,
        body: String,
        date: Double,
        taskType: TaskType,
        id: String
    ) {
        self.init()
        self.title = title
        self.body = body
        self.date = date
        self.taskType = taskType
        self.id = id
    }
    
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            guard let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return [:] }
            return jsonData
        } catch {
            return [:]
        }
    }
}
