//
//  HistoryEntity+Mapping.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/12.
//

import Foundation
import CoreData

extension HistoryEntity {
    convenience init(history: History, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        id = history.id
        title = history.title
        date = history.date
        updateType = history.updateType.description
    }
}
