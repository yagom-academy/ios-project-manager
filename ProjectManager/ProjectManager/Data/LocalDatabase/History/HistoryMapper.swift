//
//  HistoryMapper.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

extension RealmHistoryObject {
    func toDomain() -> History {
        History(
            id: self.id,
            title: self.title,
            date: self.date
        )
    }
}

extension History {
    func toObject() -> RealmHistoryObject {
        RealmHistoryObject(
            id: self.id,
            title: self.title,
            date: self.date
        )
    }
}
