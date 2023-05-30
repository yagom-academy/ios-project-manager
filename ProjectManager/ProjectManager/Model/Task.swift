//
//  Task.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/17.
//

import Foundation
import RealmSwift

struct Task: Hashable, Storable {
    var convertedDictonary: [String : Any] {
        var dict: [String: Any] = [:]
        
        dict["title"] = NSString(string: self.title)
        dict["description"] = NSString(string: self.description)
        dict["id"] = NSString(string: self.id.uuidString)
        dict["state"] = NSString(string: self.state?.titleText ?? "")
        dict["date"] = NSNumber(value: self.date.timeIntervalSince1970)
        
        return dict
    }

    var changedToDatabaseObject: Object {
        let taskObject = TaskObject()
        taskObject.id = self.id
        taskObject.title = self.title
        taskObject.desc = self.description
        taskObject.date = self.date
        taskObject.state = self.state?.titleText
        
        return taskObject
    }

    func convertToStorable(_ dict: NSDictionary?) -> Storable? {
        guard let idValue = dict?.value(forKey: "id") as? String,
              let id = UUID(uuidString: idValue),
              let title = dict?.value(forKey: "title") as? String,
              let description = dict?.value(forKey: "description") as? String,
              let stateValue = dict?.value(forKey: "state") as? String,
              let dateValue = dict?.value(forKey: "date") as? Double else { return nil }
        
        let state = TaskState.checkTodoState(by: stateValue)
        let date = Date(timeIntervalSince1970: dateValue)
        
        return Task(id: id, title: title, description: description, date: date, state: state)
    }

    func convertToStorable(_ object: Object) -> Storable? {
        guard let object = object as? TaskObject else {
            return nil
        }
        
        let task = Task(id: object.id,
                        title: object.title,
                        description: object.desc,
                        date: object.date,
                        state: TaskState.checkTodoState(by: object.state ?? ""))
        
        return task
    }

    let id: UUID
    var title: String
    var description: String
    var date: Date
    var state: TaskState? = TaskState.todo
}
