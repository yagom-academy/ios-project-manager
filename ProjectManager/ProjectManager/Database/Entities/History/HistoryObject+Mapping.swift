//
//  HistoryMapper.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

extension HistoryObject {
    func toDomain() -> History {
        History(
            id: self.id,
            title: self.title,
            date: self.date
        )
    }
}

extension History {
    func toObject() -> HistoryObject {
        HistoryObject(
            id: self.id,
            title: self.title,
            date: self.date
        )
    }
}
