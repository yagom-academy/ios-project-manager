//
//  History.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/27.
//

import RealmSwift

final class History: Object {
    @Persisted var title: String
    @Persisted var editedDate: Date = Date()
}
