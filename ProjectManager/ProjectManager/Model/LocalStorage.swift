//
//  LocalStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/22.
//

import RealmSwift

class LocalStorage: Object {
    let todoList = List<ListItemDTO>()
    let doingList = List<ListItemDTO>()
    let doneList = List<ListItemDTO>()
}
