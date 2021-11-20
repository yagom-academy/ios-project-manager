//
//  MemoEntity+Mapping.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation
import CoreData

extension MemoEntity {
    convenience init(memo: Memo, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        id = memo.id
        title = memo.title
        body = memo.description
        date = memo.date
        state = memo.status.description
    }
    
    func change(to memo: Memo) {
        setValue(memo.title, forKey: "title")
        setValue(memo.status.description, forKey: "state")
        setValue(memo.description, forKey: "body")
        setValue(memo.date, forKey: "date")
    }
}

extension MemoEntity {
    func toDomain() -> Memo {
        return Memo(id: id, title: title, description: body, date: date, status: MemoState(rawValue: state) ?? .toDo)
    }
}
