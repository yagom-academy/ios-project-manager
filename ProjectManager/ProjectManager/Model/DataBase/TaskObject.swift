//
//  TaskObject.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

import Foundation
import RealmSwift

final class TaskObject: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var state: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
