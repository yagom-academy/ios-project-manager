//
//  StorableSchedule.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/17.
//

import Foundation
import RealmSwift

class StorableSchedule: Object {

    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var dueDate = Date()
    @objc dynamic var progress = ""
    @objc dynamic var lastUpdated = Date()
}
