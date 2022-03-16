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

//    var domainSchedule: Schedule {
//        get {
//            return Schedule(
//                id: UUID(uuidString: self.id)!,
//                title: self.title,
//                body: self.body,
//                dueDate: self.dueDate,
//                progress: { switch self.progress {
//                case "TODO":
//                    return .todo
//                case "DOING":
//                    return .doing
//                case "DONE":
//                    return .done
//                default:
//                    return .todo
//                }
//                }())
//        }
//    }
}
