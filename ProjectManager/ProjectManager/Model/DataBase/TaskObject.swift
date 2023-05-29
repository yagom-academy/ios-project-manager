//
//  TaskObject.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

import Foundation
import RealmSwift

final class TaskObject: Object {
    dynamic var id: UUID = UUID()
    dynamic var title: String = ""
    dynamic var desc: String = ""
    dynamic var date: Date = Date()
    dynamic var state: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
